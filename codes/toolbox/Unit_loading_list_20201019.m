function load_list = Unit_loading_list_20201019(site,recrt)
% PLX loading sheet
% Units isolated from plx files and listed in sorting notes.
% Waveform consistency, spontaneous spiking rate consistency, sorting score
% were considered.
% Recruit larger sample size with a tolerance in one finger response:
% assign recrt = 1.

% sites: c2h_s1d1  c2h_s1d2  c2h_s3d1  c2h_s3d2  c2h_s3d3  c2h_s3d4
% c2i_s1d2  c2i_s2d1  c2g_s2d1  c2g_s3d1  c2g_s3d2  c2g_s4d1
% load_list = [ch u]
%               . .
%               . .
if nargin == 2
    if recrt==1
        switch site
            case 'c2h_s1d1'
                load_list = [1	1
                13	1
                13	2
                37	1
                37	2
                56	1
                56	2
                ];
            case 'c2h_s1d2'
                load_list = [9	1
                29	1
                31	1
                35	1
                35	2
                43	1
                51	1
                55	1
                56	1
                59	1
                63	1
                ];
            case 'c2h_s3d1' % ch9 isolated
                load_list = [8	1
                9	1
                9   2
                10	1
                14	1
                15	1
                15	2
                17	1
                19	1
                21	1
                24	1
                30	1
                35	1
                35	2
                50	1
                51	1
                52	1
                52	2
                57	1
                59	1
                63	2
                ];
            case 'c2h_s3d2'  % ch52 isolated
                load_list = [1	1
                4	1
                7	1
                7	2
                8	1
                9	1
                11	1
                15	1
                16	1
                20	1
                21	1
                22	1
                23	1
                24	1
                26	1
                27	1
                29	1
                29	2
                31	1
                34	1
                34	2
                37	1
                40	1
                41	1
                42	1
                44	1
                45	1
                46	1
                49	1
                53	2
                54	1
                54	2
                55	1
                58	1
                60	1
                61	1
                62	1
                62	2
                ];
            case 'c2h_s3d3'
                load_list = [4	1
                9	1
                14	1
                15	1
                20	1
                24	1
                37	1
                42	1
                46	1
                48	1
                49	1
                50	1
                50	2
                54	1
                61	1
                63	1
                63	2
                ];
            case 'c2h_s3d4'
                load_list = [3	1
                4	1
                4	2
                7	1
                14	1
                20	1
                30	1
                31	1
                34	1
                35	1
                36	1
                38	1
                43	1
                49	1
                54	1
                55	1
                57	1
                59	1
                61	1
                63	1
                64	1
                ];
            case 'c2i_s1d2'
                load_list = [13	1
                14	1
                15	1
                34	1
                38	1
                40	1
                40	2
                40	3
                41	1
                42	1
                44	1
                44	2
                47	1
                51	1
                52	1
                56	1
                57	1
                58	1
                58	2
                62	1
                63	1
                64	1
                64	2
                ];
            case 'c2i_s2d1'
                load_list = [2	1
                5	1
                6	1
                7	1
                10	1
                11	1
                14	1
                14	2
                15	1
                19	1
                19	2
                29	3
                32	1
                34	1
                34	2
                34	3
                37	2
                38	1
                42	1
                43	1
                46	2
                47	1
                47	2
                48	1
                48	2
                49	1
                50	1
                56	1
                56	2
                56	3
                61	1
                64	1
                ];
            case 'c2g_s2d1'
                load_list = [15	1
                15	2
                24	1
                24	2
                24	3
                35	1
                37	1
                37	2
                39	1
                43	1
                46	1
                49	1
                53	1
                55	1
                59	1
                59	2
                60	1
                63	1
                ];
            case 'c2g_s3d1'
                load_list = [2	1
                17	1
                19	1
                19	2
                24	1
                24	2
                29	1
                31	1
                31	2
                ];
            case 'c2g_s3d2'
                load_list = [1	1
                4	1
                5	1
                5	2
                5	3
                5	4
                6	1
                10	1
                11	1
                14	1
                20	1
                23	1
                24	1
                25	1
                26	1
                29	1
                37	1
                42	1
                42	2
                46	1
                ];
            case 'c2g_s4d1'
                load_list = [5	1
                5	2
                23	1
                24	1
                31	1
                33	1
                34	1
                34	2
                34	3
                40	1
                40	2
                43	1
                44	1
                44	2
                45	1
                55	1
                58	1
                58	2
                59	1
                61	1
                63	1
                ];
        %     case 'c2h_s3d1'
        %         load_list = [];
        end
    end    
end
    if nargin == 1 || (nargin == 2 && recrt==0)
        switch site
            case 'c2h_s1d1'
                load_list = [1	1
                13	1
                13	2
                37	1
                37	2
                56	1
                56	2
                ];
            case 'c2h_s1d2'
                load_list = [9	1
                29	1
                31	1
                35	1
                35	2
                43	1
                51	1
                55	1
                56	1
                59	1
                63	1
                ];
            case 'c2h_s3d1' % ch9 isolated
                load_list = [8	1
                9	1
                9   2
                10	1
                14	1
                15	1
                15	2
                17	1
                19	1
                21	1
                24	1
                35	1
                35	2
                50	1
                51	1
                52	1
                52	2
                57	1
                59	1
                63	2
                ];
            case 'c2h_s3d2'  % ch52 isolated
                load_list = [1	1
                4	1
                7	1
                7	2
                8	1
                9	1
                11	1
                15	1
                16	1
                20	1
                21	1
                22	1
                23	1
                24	1
                26	1
                27	1
                29	1
                31	1
                34	1
                37	1
                40	1
                41	1
                42	1
                44	1
                45	1
                46	1
                49	1
                53	2
                54	1
                58	1
                60	1
                61	1
                62	1
                62	2
                ];
            case 'c2h_s3d3'
                load_list = [4	1
                9	1
                14	1
                20	1
                24	1
                37	1
                42	1
                48	1
                49	1
                54	1
                61	1
                63	1
                63	2
                ];
            case 'c2h_s3d4'
                load_list = [3	1
                4	1
                4	2
                7	1
                30	1
                31	1
                34	1
                36	1
                38	1
                43	1
                49	1
                54	1
                55	1
                57	1
                59	1
                61	1
                63	1
                64	1
                ];
            case 'c2i_s1d2'
                load_list = [13	1
                14	1
                34	1
                38	1
                40	1
                40	2
                40	3
                41	1
                42	1
                44	1
                44	2
                47	1
                51	1
                52	1
                56	1
                57	1
                58	1
                58	2
                63	1
                64	1
                64	2
                ];
            case 'c2i_s2d1'
                load_list = [2	1
                5	1
                6	1
                7	1
                10	1
                11	1
                14	1
                15	1
                19	1
                19	2
                29	3
                32	1
                34	1
                34	2
                34	3
                37	2
                38	1
                42	1
                43	1
                46	2
                47	1
                48	1
                48	2
                50	1
                56	1
                56	2
                61	1
                64	1
                ];
            case 'c2g_s2d1'
                load_list = [15	1
                24	1
                24	2
                24	3
                35	1
                37	1
                39	1
                43	1
                46	1
                49	1
                53	1
                59	1
                59	2
                60	1
                63	1
                ];
            case 'c2g_s3d1'
                load_list = [2	1
                17	1
                19	1
                19	2
                24	1
                29	1
                31	2
                ];
            case 'c2g_s3d2'
                load_list = [1	1
                4	1
                5	1
                5	2
                10	1
                11	1
                14	1
                20	1
                23	1
                24	1
                25	1
                26	1
                29	1
                37	1
                42	1
                46	1
                ];
            case 'c2g_s4d1'
                load_list = [5	1
                5	2
                31	1
                34	1
                43	1
                44	1
                44	2
                59	1
                63	1
                ];
        %     case 'c2h_s3d1'
        %         load_list = [];
        end
    end
end
