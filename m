Message-ID: <37173F25.D38CAD3F@fi.infn.it>
Date: Fri, 16 Apr 1999 15:46:13 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: First attempt for LinuxPPC on a MVME2400
References: <Pine.HPP.3.96.990415204745.1720F-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
the output of the ver command is this:

PPC4-Bug>ver
Debugger/Diagnostics Type/Revision..................=PPC4/1.1
Debugger/Diagnostics Revision Date..................=01/11/99 RM01
MicroProcessor Version/Revision.....................=0008/8201
MicroProcessor Internal Clock Speed (MHZ)...........=350
MicroProcessor External Clock Speed (MHZ)...........=100
Board Type Identifier...............................=MVME2400
PCI Bus Clock Speed (MHZ)...........................=33
Local Memory Size...................................=02000000 (32MB)
L2 Cache (External).................................=0KB
L2 Cache (P0-In-Line)...............................=1024KB
L2 Cache (P1-In-Line)...............................=0KB
Super I/O Device Offset/ID/Revision.................=UNKNOWN
PCI Function 00/00/0 (00000000) ID/Revision.........=48031057/01
PCI Function 00/0B/0 (00005800) ID/Revision.........=056510AD/10
PCI Function 00/0B/1 (00005900) ID/Revision.........=010510AD/05
PCI Function 00/0D/0 (00006800) ID/Revision.........=000010E3/01
PCI Function 00/0E/0 (00007000) ID/Revision.........=00191011/41
PCI Function 00/10/0 (00008000) ID/Revision.........=00031000/13

there are some differences, and no presence of the line:
PCI Bus Bridge Device
ID/Revision...................=48011057/01                
that seems replaced by:
PCI Function 00/00/0 (00000000) ID/Revision.........=48031057/01

Do you now how to change this? (I'm very new to this kind of stuff).

Thanks

-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
