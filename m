Date: Thu, 19 Aug 1999 14:10:32 -0400 (EDT)
From: Hank De Gregorio <hcd1@acpub.duke.edu>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: New SCSI problem on MVME 2604 system
In-Reply-To: <Pine.LNX.4.10.9908191001590.8446-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.SOL.3.91.990819140715.25767A-100000@godzilla6.acpub.duke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I attached a terminator to the SCSI and it fixed my last parity error 
problem.  However, now I get the following problem:  

RAM disk driver initialized:  16 RAM disks of 4096K size
ncr53c8xx: at PCI bus 0, device 12, function 0
ncr53c8xx: 53c825a detected
ncr53c825a-0: rev=0x13, base=0x1042000, io_port=0x11000, irq=19
ncr53c825a-0: ID 7, Fast-10, Parity Checking
ncr53c825a-0: on-chip RAM at 0x1040000
ncr53c825a-0: suspicious SCSI data while resetting the BUS.
ncr53c825a-0: dp1,d15-8,dp0,d7-0,rst,req,ack,bsy,sel,atn,msg,c/d,i/o = 
0x309, expecting 0x100
ncr53c825a-0: FATAL ERROR: CHECK SCSI BUS - CABLES, TERMINATION, DEVICE 
POWER etc.!
ncr53c825a-0: detaching...
scsi : 0 hosts.
scsi : detected total.

Any more help?  Thanks in advance,

Hank


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
