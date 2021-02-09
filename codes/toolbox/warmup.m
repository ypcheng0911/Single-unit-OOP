
% Script warmup.m loads SingleUnit, RecordingSite, Monkey object format into
% Matlab runtime(?).

a = SingleUnit('warmup',[],[],[],[],[],[],[],[],[],[],[],[],[]);
b = RecordingSite('warmup',[],{a});
c = Monkey('warmup',[],[],[],[],{b});
clear
clc