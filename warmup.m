
% Script warmup.m loads SingleUnit, RecordingSite, Subject object format into
% Matlab runtime(?).

a = SingleUnit('warmup',[],[],[],[],[],[],[],[],[],[],[],[],[]);
b = RecordingSite('warmup',[],{a});
c = SUBJ('warmup',[],[],[],[],{b});
clear
clc
