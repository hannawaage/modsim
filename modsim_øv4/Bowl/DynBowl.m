function [ dstate ] = DynBowl( t, state, param, M )


    dq = state(4:end);
    
    [Mat,RHS] = BowlFile(t,state,param,M);
    
    AccAndz = Mat\RHS;
       
    ddq = AccAndz(1:3);
    

    dstate = [dq;ddq];




end

