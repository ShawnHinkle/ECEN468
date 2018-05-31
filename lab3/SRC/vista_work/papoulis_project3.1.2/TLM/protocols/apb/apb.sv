
//************************************************************
//                                                            
//      Copyright Mentor Graphics Corporation 2006 - 2011     
//                  All Rights Reserved                       
//                                                            
//       THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY      
//         INFORMATION WHICH IS THE PROPERTY OF MENTOR        
//         GRAPHICS CORPORATION OR ITS LICENSORS AND IS       
//                 SUBJECT TO LICENSE TERMS.                  
//                                                            
//************************************************************


// Generated by Model Builder 

module apb_protocol
#(string	__portPath = "",
parameter	int	__portCount = 0,
parameter	string	__snapshotPath = "",
parameter	int	__timeFactor = 1
)

  (
    input DUMMY, 
    (*	clk	*)	input	PCLK, 
    (*	master	*)	input	[31:0]	PADDR	/* isAddress = 1 */, 
    (*	master	*)	input	PWRITE, 
    (*	master	*)	input	PSEL, 
    (*	master	*)	input	PENABLE, 
    (*	master	*)	input	[31:0]	PWDATA	/* isAddress = 0 */, 
    (*	slave	*)	input	[31:0]	PRDATA	/* isAddress = 0 */, 
    (*	slave	=	1	*)	input	PREADY, 
    (*	slave	=	0	*)	input	PSLVERROR
  );

chandle __pMessageHandler;
chandle __pPort;
import "DPI-C" pure function void Papoulis_ReadVCD_ProtocolError(input string reason, input string functionName, input longint unsigned stime, input chandle pMessageHandler);

`ifdef OPEN_ARRAYS  
import "DPI-C" function void Papoulis_ReadVCD_SendMessage(
`else
import "DPI-C" function void Papoulis_ReadVCD_OldSendMessage(
`endif
input chandle pMessageHandler, input chandle pPort, input string messageName, input longint unsigned stime
`ifdef OPEN_ARRAYS  
, input longint unsigned paramArray []
`else
, input longint unsigned p1, input longint unsigned p2, input longint unsigned p3
`endif
);


import "DPI-C" function chandle Papoulis_ReadVCD_GetPortHandle(input chandle pMessageHandler, input string portPath);
import "DPI-C" function chandle Papoulis_ReadVCD_GetMessageHandler(input string snapshotPath, input int factor);


import "DPI-C" pure function int Papoulis_ReadVCD_CycleTimeSet(input chandle pMessageHandler, input string portPath, input longint unsigned low, input longint unsigned high);
import "DPI-C" pure function void Papoulis_ReadVCD_SaveCycleClkTime( input chandle pMessageHandler, input chandle pPort, input longint unsigned low, input longint unsigned high);
task findCycleTime();
    time currentTime;
    time lowTime;
    time highTime;
    integer isAlreadySet; 
    
    isAlreadySet	=	0;
begin
    while (!isAlreadySet) 
    begin
        @(negedge PCLK);
        currentTime = $time;
        @(posedge PCLK);
        lowTime = $time - currentTime;
        currentTime = $time;
        @(negedge PCLK);
        highTime = $time - currentTime;
        isAlreadySet = Papoulis_ReadVCD_CycleTimeSet(__pMessageHandler, __portPath, lowTime, highTime);
    end
    Papoulis_ReadVCD_SaveCycleClkTime(__pMessageHandler, __pPort, lowTime, highTime);
end
endtask

initial
	findCycleTime();


function void READ_REQ(input longint unsigned PADDR, input longint unsigned block_size);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = PADDR;
	paramArray[1] = block_size;
	paramArray[2] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "READ_REQ", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "READ_REQ", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, PADDR, block_size, 0
`endif
);
$display("%0t/I, %m :- READ_REQ(PADDR=%0h, block_size=%0d)",$time,PADDR,
block_size);
endfunction


function void read_ack(input longint unsigned PRDATA);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = PRDATA;
	paramArray[1] = 0;
	paramArray[2] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "read_ack", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "read_ack", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, PRDATA, 0, 0
`endif
);
$display("%0t/O, %m :- read_ack(PRDATA=%0h)",$time,PRDATA);
endfunction


function void read_error();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "read_error", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "read_error", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0
`endif
);
$display("%0t/O, %m :- read_error()",$time);
endfunction


function void WRITE_REQ(input longint unsigned PADDR, input longint unsigned PWDATA, input longint unsigned block_size);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = PADDR;
	paramArray[1] = PWDATA;
	paramArray[2] = block_size;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "WRITE_REQ", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "WRITE_REQ", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, PADDR, PWDATA, block_size
`endif
);
$display("%0t/I, %m :- WRITE_REQ(PADDR=%0h, PWDATA=%0h, block_size=%0d)",$time
,PADDR,PWDATA,block_size);
endfunction


function void write_ack();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "write_ack", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "write_ack", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0
`endif
);
$display("%0t/O, %m :- write_ack()",$time);
endfunction


function void write_error();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "write_error", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "write_error", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0
`endif
);
$display("%0t/O, %m :- write_error()",$time);
endfunction


function void END_TRANSACTION();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = 1;
	paramArray[1] = 0;
	paramArray[2] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "END_TRANSACTION", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "END_TRANSACTION", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 1, 0, 0
`endif
);
$display("%0t/I, %m :- END_TRANSACTION()",$time);
endfunction


function void protocolError;
input error;
string error;
$display($time," --> ERROR in %m");
Papoulis_ReadVCD_ProtocolError(error, "protocolError", $time, __pMessageHandler);
endfunction

typedef enum int {IDLE=0, ENABLE_READ, ENABLE_WRITE, STANDBY_READ, 
STANDBY_WRITE}  PROTOCOL_STATES;
PROTOCOL_STATES protocolState;
(* protocol_initial *)
initial
    protocolState = IDLE;
initial
begin
    __pMessageHandler = Papoulis_ReadVCD_GetMessageHandler(__snapshotPath, __timeFactor);
    __pPort = Papoulis_ReadVCD_GetPortHandle(__pMessageHandler, __portPath);
    while(1)
begin 
    case (protocolState)
    IDLE:
        begin 
            if ((PSEL!==1'b1))
            begin 
                protocolState = IDLE;
                @(negedge PCLK)
                    ;
            end
            else
                if ((PWRITE==1'b0))
                begin 
                    protocolState = ENABLE_READ;
                    (* READ *)
                    READ_REQ(PADDR,4);
                    @(negedge PCLK)
                        ;
                end
                else
                    if ((PWRITE==1'b1))
                    begin 
                        protocolState = ENABLE_WRITE;
                        (* WRITE *)
                        WRITE_REQ(PADDR,PWDATA,4);
                        @(negedge PCLK)
                            ;
                    end
                    else
                    begin 
                        protocolError("protocol apb sequence is wrong in state IDLE");
                        @(negedge PCLK)
                            ;
                    end
        end
    ENABLE_READ:
        begin 
            if ((PREADY==1'b0))
            begin 
                protocolState = ENABLE_READ;
                @(negedge PCLK)
                    ;
            end
            else
                if ((PSLVERROR==1'b1))
                begin 
                    protocolState = STANDBY_READ;
                    read_error();
                    @(negedge PCLK)
                        ;
                end
                else
                    if ((PENABLE&&(PWRITE==1'b0)))
                    begin 
                        protocolState = STANDBY_READ;
                        read_ack(PRDATA);
                        @(negedge PCLK)
                            ;
                    end
                    else
                    begin 
                        protocolError("protocol apb sequence is wrong in state ENABLE_READ");
                        @(negedge PCLK)
                            ;
                    end
        end
    ENABLE_WRITE:
        begin 
            if ((PREADY==1'b0))
            begin 
                protocolState = ENABLE_WRITE;
                @(negedge PCLK)
                    ;
            end
            else
                if ((PSLVERROR==1'b1))
                begin 
                    protocolState = STANDBY_WRITE;
                    write_error();
                    @(negedge PCLK)
                        ;
                end
                else
                    if ((PENABLE&&(PWRITE==1'b1)))
                    begin 
                        protocolState = STANDBY_WRITE;
                        write_ack();
                        @(negedge PCLK)
                            ;
                    end
                    else
                    begin 
                        protocolError("protocol apb sequence is wrong in state ENABLE_WRITE");
                        @(negedge PCLK)
                            ;
                    end
        end
    STANDBY_READ:
        begin 
            if ((PSEL!==1'b1))
            begin 
                protocolState = IDLE;
                END_TRANSACTION();
                @(negedge PCLK)
                    ;
            end
            else
                if ((PWRITE==1'b0))
                begin 
                    protocolState = ENABLE_READ;
                    READ_REQ(PADDR,4);
                    @(negedge PCLK)
                        ;
                end
                else
                begin 
                    protocolError("protocol apb sequence is wrong in %m state STANDBY_READ");
                    @(negedge PCLK)
                        ;
                end
        end
    STANDBY_WRITE:
        begin 
            if ((PSEL!==1'b1))
            begin 
                protocolState = IDLE;
                END_TRANSACTION();
                @(negedge PCLK)
                    ;
            end
            else
                if ((PWRITE==1'b1))
                begin 
                    protocolState = ENABLE_WRITE;
                    WRITE_REQ(PADDR,PWDATA,4);
                    @(negedge PCLK)
                        ;
                end
                else
                begin 
                    protocolError("protocol apb sequence is wrong in %m state STANDBY_WRITE");
                    @(negedge PCLK)
                        ;
                end
        end
    endcase
end
end
endmodule
