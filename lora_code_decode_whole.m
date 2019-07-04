
%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
% Author : Sakshama Ghoslya                        %
%          IIT Hyderabad, Hyderabad, India       %
% Email  : sakshama.ghosliya@gmail.com     %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%


clear all; close all; clc;

%% Cockpit of the simulator

SF = 7;                     % Spreading Factor from 7 to 12 
BW = 125000;                 % 125kHz
Fs = 125000;                 % Sampling Frequency
preamble_len = 1;            % Preamble length
sync_len = 1;                % Sync length
num_samples = Fs*(2^SF)/BW;  % Number of samples
                             % 100 symbols to test the simulation :: choose 'total_sym'
symbols = [55];
       
total_sym = 1;              % total symbols excluding preamble and sync from 1:100

lora_total_sym = preamble_len + sync_len + total_sym; % Total transmitted symbols


%% Preamble Generation
inverse = 0;
for i = 1:preamble_len
    [out_preamble] = LoRa_Modulation(SF,BW,Fs,num_samples,0,inverse);
    outp((i-1)*num_samples+1 : i*num_samples) = out_preamble;
end

%% Sync Symble Generation
inverse = 1;
for i = 1:sync_len
    [out_sync] = LoRa_Modulation(SF,BW,Fs,num_samples,32,inverse);
    outp = [outp out_sync];
end

%% Symble Generation
inverse = 0;
for i = 1:total_sym
    [out_sym] = LoRa_Modulation(SF,BW,Fs,num_samples,symbols(i),inverse);
    outp = [outp out_sym];
end

%% Reverse chirp generation for receiver
inverse = 1;

[out_reverse] = LoRa_Modulation(SF,BW,Fs,num_samples,0,inverse);
% Multiplying with the reverse chirp 
for n = 1:1:lora_total_sym
    decoded_out((n-1)*num_samples + 1 : n*num_samples) = (outp((n-1)*num_samples + 1 : n*num_samples).*out_reverse);
end

%%% test one symbol fft.
n=lora_total_sym;
symbol_temp = outp((n-1)*num_samples + 1 : n*num_samples);
symbol_fft = abs(fft(symbol_temp));

%% Calculating FFT
for m = 1:1:lora_total_sym
    FFT_out(m,:) = abs((fft(decoded_out((m-1)*num_samples + 1 : m*num_samples))));
end

%% Decoding the received data
k=1;
    for m = preamble_len+sync_len+1:1:lora_total_sym
         [r,c] = max(FFT_out(m,:));
         data_received(k) = c-1;
         k = k+1;
    end

%% Plotting 

% Plotting the Spectrogram of Transmitted signal
figure;
samples = num_samples/4;
title('Decoded LoRa symbols');
spectrogram(decoded_out,samples,samples-1,samples,Fs,'yaxis');

% ploting original receied signals.
figure;
samp_time = 0:1:num_samples-1;
title('FFT of orignal LoRa symbols');
% for m = 1:1:lora_total_sym
%     plot(samp_time,FFT_out(m,:)); hold on;
% end
plot(samp_time,symbol_fft);

% Plotting the received frequencies
figure;
samp_time = 0:1:num_samples-1;
title('FFT of received LoRa symbols after multiplying reverse signals');
% for m = 1:1:lora_total_sym
%     plot(samp_time,FFT_out(m,:)); hold on;
% end
plot(samp_time,FFT_out(lora_total_sym,:));
grid on;



