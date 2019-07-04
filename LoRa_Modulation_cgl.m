
%%%%%%%%%%%%%%%%%%%%%%%
%                                                                      %
% Author : Sakshama Ghoslya                        %
%          IIT Hyderabad, Hyderabad, India       %
% Email  : sakshama.ghosliya@gmail.com     %
%                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%

% Matlab function to Modulate LoRa symbols
%%% cgl, directly modify to return the modulation frequency sequency.

function out_preamble = LoRa_Modulation_cgl(SF,BW,Fs,num_samples,symbol,inverse)

    %initialization
    phase = 0;
    Frequency_Offset = (Fs/2) - (BW/2);

    shift = symbol;
    out_preamble = zeros(1,num_samples);
    
    modu_freq_list = [];
    modu_freq_list2 = [];

    newPhase_list = [];
    
    for k=1:num_samples
   
        %output the complex signal
        newPhase = phase*Fs;
        
%         out_preamble(k) = cos(newPhase) + 1i*sin(newPhase);
        newPhase_list = [newPhase_list newPhase];
        
        % Frequency from cyclic shift
        f = BW*shift/(2^SF);
        modu_freq_list2 = [modu_freq_list2 f];
        out_preamble(k) = f;
        if(inverse == 1)
               f = BW - f;
        end
    
        %apply Frequency offset away from DC
        f = f + Frequency_Offset;
    
        % Increase the phase according to frequency. This includes adds a
        % simple point with 2_pi_f.
        phase = phase + 2*pi*f/Fs;
        modu_freq_list = [modu_freq_list phase/(2*pi)];
        if phase > pi
            phase = phase - 2*pi;
        end
    
        %update cyclic shift
        shift = shift + BW/Fs;
        if shift >= (2^SF)
            shift = shift - 2^SF;
        end
    end
%     modu_freq_list
    modu_freq_list2
% newPhase_list
end