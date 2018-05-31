
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

module signal_protocol
#(string	__portPath = "",
parameter	int	__portCount = 0,
parameter	string	__snapshotPath = "",
parameter	int	__timeFactor = 1
)

  (
    input DUMMY, 
    (*	clk	*)	input	CLK, 
    (*	master	*)	input	VALUE
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

reg prevValue;

function void Set(input longint unsigned address, input longint unsigned value_p, input longint unsigned block_size);
`ifdef OPEN_ARRAYS  
	longint unsigned paramArray [0 : 2];
	paramArray[0] = address;
	paramArray[1] = value_p;
	paramArray[2] = block_size;
`endif
`ifdef OPEN_ARRAYS  
	Papoulis_ReadVCD_SendMessage(__pMessageHandler, __pPort, "Set", $time
`else
	Papoulis_ReadVCD_OldSendMessage(__pMessageHandler, __pPort, "Set", $time
`endif
`ifdef OPEN_ARRAYS  
, paramArray
`else
, address, value_p, block_size
`endif
);
endfunction

typedef enum int {idle=0}  State;
State state;
(* protocol_initial *)
initial
    state = idle;
initial
    prevValue = 0;
initial
begin
    __pMessageHandler = Papoulis_ReadVCD_GetMessageHandler(__snapshotPath, __timeFactor);
    __pPort = Papoulis_ReadVCD_GetPortHandle(__pMessageHandler, __portPath);
    while(1)
begin 
    case (state)
    idle:
        begin 
            if ((((VALUE!==prevValue)&&(VALUE!==1'bx))&&($time!=0)))
            begin 
                (* WRITE *)
                Set(0,VALUE,1);
                prevValue = VALUE;
                @(negedge CLK)
                    ;
            end
            else
            begin 
                prevValue = VALUE;
                @(negedge CLK)
                    ;
            end
        end
    endcase
end
end
endmodule
