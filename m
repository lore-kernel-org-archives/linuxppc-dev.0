Date: Mon, 1 Mar 1999 16:56:43 +0100 (MET)
From: "David.DeRidder" <s970707@uia.ua.ac.be>
Reply-To: loopback <david.de.ridder@bitsmart.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel boot arguments over network
Message-ID: <Pine.SO4.4.05.9903011559500.22676-100000@hsins.uia.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

in my continueing efforts to get our MVME2306 board running, I ran
across another problem. All Linux (mini-)HOWTOs talk about passing
boot arguments (like 'root=/dev/nfs') to the kernel. Some also
mention the case where one is booting a diskless station (such as
an MVME230x board). However, no document describes *how* to pass these
arguments over the network to the kernel.

I'm starting to doubt whether this is possible. I want the BOOTP/TFTP
server to have the initial boot arguments for each of its clients, and
pass them when a client (i.c. an MVME2306 board) boots over the
network. Other than the file name, BOOTP doesn't seem capable to me
to passing anything as long as a command line - but I may be wrong.

I am aware of the fact that both 'NBO' and 'NIOT' allow setting some
"Argument File Name". Is this supposed to be an ASCII file with the
arguments in them ? The PPC-Bug documentation is rather vague about
this matter. (In my TFTP logs, nothing seems to indicate that the
board is trying to load this 'Argument File'.)

All help and suggestions are welcomed,

+-----------------------------------------------------------------+
|   David 'Septimus' De Ridder   | "Never underestimate the       |  
|                                |  power of the soul unleashed." |
| <david.de.ridder@bitsmart.com> |   - 'Essence Flare', M:TG      |
+-----------------------------------------------------------------+

--
"- Do you think this show constitutes cruelty to animals ?
 - Not unless their watching it !"
   - 'The Muppet Show' 



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
