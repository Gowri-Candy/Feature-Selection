for i=1:20
    vfo_auto_fs
    n=i+5;
    fname=strcat('VFO_FS_Auto',num2str(n))
    save (fname)
    Bestloop(i)=BestSol;
end