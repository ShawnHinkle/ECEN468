
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

module generic_protocol
#(
    parameter WIDTH = 32, 
    string	__portPath = "",
    parameter	int	__portCount = 0,
    parameter	string	__snapshotPath = "",
    parameter	int	__timeFactor = 1
)

  (
    input DUMMY, 
    (*	clk	*)	input	CLK, 
    (*	master	*)	input	CS, 
    (*	master	*)	input	CMD, 
    (*	master	=	0	*)	input	[7:0]	PRIORITY	/* isAddress = 0 */, 
    (*	master	=	1	*)	input	[7:0]	BURST	/* isAddress = 0 */, 
    (*	master	=	2	*)	input	[7:0]	SIZE	/* isAddress = 0 */, 
    (*	master	*)	input	[WIDTH - 1:0]	ADDR	/* isAddress = 1 */, 
    (*	master	*)	input	[WIDTH - 1:0]	wDATA	/* isAddress = 0 */, 
    (*	slave	*)	input	[WIDTH - 1:0]	rDATA	/* isAddress = 0 */, 
    (*	slave	=	1	*)	input	STATUS
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
, input longint unsigned p1, input longint unsigned p2, input longint unsigned p3, input longint unsigned p4
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
        @(negedge CLK);
        currentTime = $time;
        @(posedge CLK);
        lowTime = $time - currentTime;
        currentTime = $time;
        @(negedge CLK);
        highTime = $time - currentTime;
        isAlreadySet = Papoulis_ReadVCD_CycleTimeSet(__pMessageHandler, __portPath, lowTime, highTime);
    end
    Papoulis_ReadVCD_SaveCycleClkTime(__pMessageHandler, __pPort, lowTime, highTime);
end
endtask

initial
	findCycleTime();

int BurstCount = 0;

function void G_WRITE(input longint unsigned ADDR, input longint unsigned PRIORITY, input longint unsigned BURST, input longint unsigned SIZE);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = ADDR;
	paramArray[1] = PRIORITY;
	paramArray[2] = BURST;
	paramArray[3] = SIZE;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "G_WRITE", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "G_WRITE", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, ADDR, PRIORITY, BURST, SIZE
`endif
);
endfunction


function void G_WRITE_DATA(input longint unsigned wDATA);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = wDATA;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "G_WRITE_DATA", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "G_WRITE_DATA", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, wDATA, 0, 0, 0
`endif
);
endfunction


function void g_write_resp(input longint unsigned STATUS, input longint unsigned BurstCount);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = STATUS;
	paramArray[1] = BurstCount;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "g_write_resp", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "g_write_resp", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, STATUS, BurstCount, 0, 0
`endif
);
endfunction


function void G_READ(input longint unsigned ADDR, input longint unsigned PRIORITY, input longint unsigned BURST, input longint unsigned SIZE);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = ADDR;
	paramArray[1] = PRIORITY;
	paramArray[2] = BURST;
	paramArray[3] = SIZE;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "G_READ", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "G_READ", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, ADDR, PRIORITY, BURST, SIZE
`endif
);
endfunction


function void G_READ_DATA();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 0;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "G_READ_DATA", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "G_READ_DATA", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 0, 0, 0, 0
`endif
);
endfunction


function void g_read_resp(input longint unsigned rDATA, input longint unsigned STATUS, input longint unsigned BurstCount);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = rDATA;
	paramArray[1] = STATUS;
	paramArray[2] = BurstCount;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "g_read_resp", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "g_read_resp", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, rDATA, STATUS, BurstCount, 0
`endif
);
endfunction


function void END_TRANSACTION();
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 3];
	paramArray[0] = 1;
	paramArray[1] = 0;
	paramArray[2] = 0;
	paramArray[3] = 0;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "END_TRANSACTION", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "END_TRANSACTION", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, 1, 0, 0, 0
`endif
);
endfunction

typedef enum int {IDLE=0, R_DATA, R_RESP, W_DATA, W_RESP}  PROTOCOL_STATES;
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
            if (((CS===1'b1)&&(CMD===1'b1)))
            begin 
                protocolState = W_DATA;
                (* WRITE *)
                G_WRITE(ADDR,PRIORITY,BURST,(1 << SIZE));
                BurstCount = BURST;
            end
            else
                if (((CS===1'b1)&&(CMD===1'b0)))
                begin 
                    protocolState = R_DATA;
                    (* READ *)
                    G_READ(ADDR,PRIORITY,BURST,(1 << SIZE));
                    BurstCount = BURST;
                end
                else
                begin 
                    protocolState = IDLE;
                    @(negedge CLK)
                        ;
                end
        end
    W_DATA:
        begin 
            if ((BurstCount==0))
            begin 
                protocolState = IDLE;
                END_TRANSACTION();
                @(negedge CLK)
                    ;
            end
            else
                if (STATUS)
                begin 
                    protocolState = W_RESP;
                    G_WRITE_DATA(wDATA);
                    BurstCount = (BurstCount - 1);
                end
                else
                begin 
                    protocolState = W_DATA;
                    @(negedge CLK)
                        ;
                end
        end
    W_RESP:
        begin 
            protocolState = W_DATA;
            g_write_resp(STATUS,BurstCount);
            @(negedge CLK)
                ;
        end
    R_DATA:
        begin 
            if ((BurstCount==0))
            begin 
                protocolState = IDLE;
                END_TRANSACTION();
                @(negedge CLK)
                    ;
            end
            else
                if (STATUS)
                begin 
                    protocolState = R_RESP;
                    G_READ_DATA();
                    BurstCount = (BurstCount - 1);
                end
                else
                begin 
                    protocolState = R_DATA;
                    @(negedge CLK)
                        ;
                end
        end
    R_RESP:
        begin 
            protocolState = R_DATA;
            g_read_resp(rDATA,STATUS,BurstCount);
            @(negedge CLK)
                ;
        end
    endcase
end
end
endmodule
