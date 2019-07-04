function y_ca=freq_to_timerser(freq_seq, fs, N, amplitude)

%%% the frequency has been modulated into the complex signal. it means that
%%% we get y = real*cos(2*pi*f*1) + imageI*sin(2*pi*f*1); we get only the first one
%%% point for each.
% complex_signal: is the signal
% fs: is the sampling frequency
% N: is the sampling points and also the length of the output time series.

% close all;
y_ca =[];

% complex_signal = 0.707106781186547 - 0.707106781186548i;

% freq_list = [];
%%% using the sampling frequency of the maximum frequency.
if fs == -1
    fs = max(freq_seq)*100;
end

for i=1:length(freq_seq)

    if amplitude == -1
        amplitude = 1;
    end

%     freq = cos_ele/(2*pi); % Hz.
    freq = freq_seq(i);
%     freq_list = [freq_list freq];


    % N =1000;
    if N == -1
        N =1000;
    end
    Ts=1/fs;%sampling interval
    t=0:Ts:(N-1)*Ts; % sampling time

    y_p = cos(2*pi*freq*t)+ sin(2*pi*freq*t);


    %%% normalized the singal.
%     y_p = y_p/(max(y_p)-min(y_p));
    y_p = y_p/max(y_p);

    y_p = amplitude*y_p;

    y_ca = [y_ca y_p];
end




%%% show the fft results.

% figure;
% subplot(211)
% plot(y_ca);
% title(sprintf('freq=%dHz',freq))
% xlabel('Time');
% ylabel('Amplitude');
% 
% subplot(212);
% hua_fft_norm(y_ca,fs,2)


% fft_sig = abs(fft(y_p));
% plot(fft_sig(1:length(fft_sig)/2))
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

% freq_list



end