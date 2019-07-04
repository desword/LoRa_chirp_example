%-----------------lora Transmitter-------------------- 

%%% @cgl.lora insertion test. 
SF = 7;                     % Spreading Factor from 7 to 12 
BW = 125000;                 % 125kHz
Fs = 125000;                 % Sampling Frequency
preamble_len = 8;            % Preamble length
sync_len = 2;                % Sync length
num_modu_Freq = Fs*(2^SF)/BW;  % Number of samples
modulated_symbol = 20;       % the symbol to be modulated. SF=7,(0~128)
inverse = 0;
out_freq = LoRa_Modulation_cgl(SF,BW,Fs,num_modu_Freq,modulated_symbol,inverse); %% Now the return is the frequency.

% transform into time series of lora signals. [TODO] to calculate a proper
% fs, N based on wifi parameters. That create a proper singal overlap.
amplitude = 0.01;
fs_lora=-1;
Nsample=num_samples;
% figure;
Lora_carrier=freq_to_timerser(out_freq, fs_lora, Nsample,amplitude);

fftout = abs(fft(Lora_carrier));
plot(fftout(1:length(fftout)/2))

%-----------------LoRa reverse chirp multiple test-------------------- 


inverse = 1;
out_reverse = LoRa_Modulation_cgl(SF,BW,Fs,num_modu_Freq,0,inverse);
amplitude = 0.01;
fs_lora=-1;
Nsample=num_samples;
% figure;
Lora_reverse=freq_to_timerser(out_reverse, fs_lora, Nsample,amplitude);


Multiple_reverchirp = Lora_carrier.*Lora_reverse;
figure;
% fftout = abs(fft(Multiple_reverchirp));
% samp_time = 0:1:num_modu_Freq*num_samples-1;
% plot( fftout)
subplot(311);
hua_fft_norm(Lora_carrier,num_modu_Freq*num_samples,2);
title('Lora_carrier FFT');
% ylim([0 700]);
subplot(312);
hua_fft_norm(Lora_reverse,num_modu_Freq*num_samples,2);
% ylim([0 700]);
title('Lora_reverse FFT');
subplot(313);
hua_fft_norm(Multiple_reverchirp,num_modu_Freq*num_samples,2);
% ylim([0 700]);
title('Multiple_reverchirp FFT');