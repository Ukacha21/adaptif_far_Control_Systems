clc; clear; close all;

%% 1. SİSTEM PARAMETRELERİ (Tahmini/Ölçülen Değerler)
R  = 10;       % Direnç (Ohm)
Kt = 0.012;    % Tork Sabiti (Nm/A)
Kb = 0.012;    % Zıt EMF Sabiti (V.s/rad)
N  = 100;      % Dişli Oranı (100:1)
K  = 15; %bizde rulman var       % Kaplin Yay Sertliği (Nm/rad)
JL = 0.003;    % Taret + Alyan Atalet Momenti (kg.m^2)

%% 2. TRANSFER FONKSİYONU OLUŞTURMA
% G(s) = Theta_L(s) / V(s)

% Pay (Numerator): Kt * N * K
num = [Kt * N * K];

% Payda (Denominator): s * [ (R*JL)s^2 + (Kt*Kb*N^2)s + (R*K) ]
% Açılımı: (R*JL)s^3 + (Kt*Kb*N^2)s^2 + (R*K)s + 0
den = [ (R*JL),  (Kt*Kb*N^2),  (R*K),  0 ];

% Açık Çevrim Sistemi Tanımla (TF nesnesi)
G_sistem = tf(num, den);

disp('Sistemin Açık Çevrim Transfer Fonksiyonu:');
G_sistem;

%% 3. PID KONTROLCÜ VE KAPALI ÇEVRİM
% Senin kodundaki değerler: Kp=6, Ki=0.6, Kd=0.35
Kp = 6;
Ki = 0.6;
Kd = 0.35;

C_pid = pid(Kp, Ki, Kd);

% Kapalı Çevrim (Feedback) Oluşturma
% feedback(Sistem, 1) komutu varsayılan olarak NEGATİF geri besleme yapar.
T_kapali_cevrim = feedback(C_pid * G_sistem, 1);

%% 4. GRAFİK ÇİZDİRME (Basamak Tepkisi)
figure;
step(T_kapali_cevrim); % Sisteme 1 birimlik (Radyan) komut verilir
grid on;
title('PID Kontrollü Taret Konum Tepkisi (Simulink Sağlaması)');
xlabel('Zaman (saniye)');
ylabel('Açı (Radyan)');

% Hedef çizgisi (Görsellik için)
yline(1, '--r', 'Hedef (1 Radyan)');