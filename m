Message-ID: <37AFA3A3.370B25CB@stny.rr.com>
Date: Mon, 09 Aug 1999 23:59:31 -0400
From: Patrick Berge <pberge@stny.rr.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: mace:transmit timeout - resetting
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 I have am receiving "mace:transmit timeout - resetting" sporadically.
It occurs while running VNC ( http://www.uk.research.att.com/vnc) .
Ping, telnet and even IP Masquerading are working fine on all machines.
I have one Power Mac with PPCLinux (R5-Kernel 2.2.6-15apmac) , an Intel
box (Red Hat 6.0 - Kernel-2.2.5-15) which is the gateway  and an AMD
box (RedHat 5.1- Kernel 2.0.34).    I only see this error on PPC Linux
console when transmitting to the Intel box  with either Linux or Windows
95 (Sorry it came with PC and used it to see if it was just Red Hat 6.0
causing my problem).  I am betting I need to increase the timeout in
the  /usr/src/linux/drivers/net/mace.c file? Although I don not
understand why, since the connection to the AMD box is fine.  I swapped
the ethernet cards (except the built-in) /cables and hub ports and
always get the  same problem.  I even disabled IP Masquerading think
that was the problem ... but I still had the problem.

 I am not sure but I think the line I need to change is in
/usr/src/linux/drivers/net/mace.c file shown below? Not sure what to
change it to?

 #define TX_TIMEOUT HZ /* 1 second */

Any ideas about my problem and/or the meaning of the HZ would be
helpful.

Patrick Berge


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
