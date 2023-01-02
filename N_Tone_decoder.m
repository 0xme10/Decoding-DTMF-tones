%Ali Mohammed
%1507027647
%DTMF DEOCDER USING FFT By finding the peaks and then applying frequency of
% low & high peak to the correct keypad.
%if the signal is noisy it has to be passed through a gaussian filter first or
%through a clustering ML algorithm to identify the frequencies of the
%signal
%playSignal sound
dialed_tone = [ 0 0 0 ];
sound(Signal,Fs);

lengthh = 3;%set the amount of tones u want to decode
d = floor(length(Signal)/lengthh); %round down the length of the signal/n number of tones
for j = 1:lengthh
    if j-1 == 0
        start = 1;
    else
        start = (j-1)*d;
    end

%preform FFT provides frequency information about the signal (get the dft)
p = abs(fft(Signal(start:j*d)));
n = length(Signal(start:j*d));

%get the proper frequencies of the signal and plot them 
f = (0:n-1)*(Fs/n);
subplot(4,3,j)
plot(f,p) %freq amp graph for each signal
 xlabel('Frequency')
 ylabel('Amplitude')

%use findpeaks to determine the peaks above 300 (minpeakheight);
[a, location] = findpeaks(p,'Minpeakheight',480);

%change location into frequency 
freq = f(location);

%limit to our DTMF to less then 2000
peak_freq = freq(freq< 2000 );

%peak freq shows the frequencies in the dialtone where two signals are high
%adn the other is low.


%round the frequencies min&&max
low_freq = ceil(peak_freq(1));
high_freq = ceil(peak_freq(2));

%see outputs of high and low
sprintf('%f', low_freq)
sprintf('%f', high_freq)

%determine which number it is w/ high and low frequencies with their
%mangintude

for dial_counter = j:j
if (low_freq >= 685 && low_freq <= 710) && (high_freq >= 1330 && high_freq <= 1380)
    dialed_tone(dial_counter)=1;
    elseif (low_freq >= 840 && low_freq <= 890)  && (high_freq >= 1330 && high_freq <= 1380)
    dialed_tone(dial_counter)=2;
    elseif (low_freq >= 740 && low_freq <= 800 ) && (high_freq >= 1330 && high_freq <= 1380)
    dialed_tone(dial_counter)=3;
    elseif (low_freq >= 685 && low_freq <= 710) && (high_freq >= 1450 && high_freq <= 1500)
   dialed_tone(dial_counter)=4;
    elseif (low_freq >= 840 && low_freq <= 890) && (high_freq >= 1450 && high_freq <= 1500)
    dialed_tone(dial_counter)=5;
    elseif (low_freq >= 740 && low_freq <= 800) && (high_freq >= 1450 && high_freq <= 1500)
    dialed_tone(dial_counter)=6;
    elseif (low_freq >= 685 && low_freq <= 710) && (high_freq >= 1199 && high_freq <= 1240)
    dialed_tone(dial_counter)=7;
    elseif (low_freq >= 840 && low_freq <= 890) && (high_freq >= 1199 && high_freq <= 1240)
    dialed_tone(dial_counter)=8;
    elseif (low_freq >= 740 && low_freq <= 800) && (high_freq >= 1199 && high_freq <= 1240)
    dialed_tone(dial_counter)=9;
end
end
end

