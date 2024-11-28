`timescale 1ns / 1ps
module CU(op,
          fun7,
          fun3,
          alu_control,
          regwrite,
          ALUsrc,
          memwrite,
          resultsrc,
          branch,
          jump,
          immsrc,
          AUIPC,
          sh_D,
          sb_D,
          lh_D,
          lb_D);
input [6:0]op,fun7;
input [2:0]fun3;
output [5:0]alu_control;
output regwrite,
       memwrite,
       resultsrc,
       branch,
       jump,
       AUIPC,
       sh_D,
       sb_D,
       lh_D,
       lb_D;
output [1:0]ALUsrc;       
output [2:0]immsrc;
    main_decoder flag_decoder(.op(op),
                              .fun3(fun3),
                              .regwrite(regwrite),
                              .ALUsrc(ALUsrc),
                              .memwrite(memwrite),
                              .resultsrc(resultsrc),
                              .branch(branch),
                              .jump(jump),
                              .immsrc(immsrc),
                              .AUIPC(AUIPC),
                              .sh_D(sh_D),
                              .sb_D(sb_D),
                              .lh_D(lh_D),
                              .lb_D(lb_D));
    alu_decoder alu_decoder(.op(op),
                            .fun3(fun3),
                            .fun7(fun7),
                            .alu_control(alu_control));
endmodule
