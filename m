Message-Id: <199902091212.NAA23161@kieray1>
Date: Tue, 9 Feb 1999 13:12:53 +0100 (MET)
From: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Reply-To: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
Subject: FADS860 nfsroot
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anyone else with embedded 860 linux that has problems with nfsroot?

The zImage.fads-2.1.127 hangs for me right when it's supposed to display 
"bash#"

My MBX-board works just fine with nfsroot connected to the same server.

I haven't made any deep investigation about the FADS case above yet,
but I suspect that it is the same problem as I've got with my ADS board. 

It booted with initrd and I could even mount nfs with "mount -t nfs".
But nfsroot didn't work.

I've made some printouts to see what happens when "/bin/sh" is loaded,
and run the new kernel on both the MBX and the ADS board.
They start doing the same thing but after a while the ADS code goes wild
and opens some directory and differs completly from the MBX board.
Then it hangs.

I've thought that my crosscompiler 
(ppc-linux-gnu-gcc -dumpversion gives egcs-2.91.57)
was a bit buggy, but now when I've downloaded the zImage directly from the
embedded directory and my board hangs, I don't know what to belive...

It might be my FADS board that sucks? 
I've got a PILOT motherboard and a PILOT 860Tboard.

On the list the 12-Jan Dan Malek tells us that his FADS board has problems
using anything else than initrd. 

I'm using a hacked version fadsrom which uses a msdos partitiontable
instead of OSF to boot the zImage.fads-2.1.127 from a compact flash card.

Anyone with similar problems?

Anyone out there with a ADS-board?

TIA /

Magnus 


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
