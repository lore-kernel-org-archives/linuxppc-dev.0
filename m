Message-Id: <3.0.6.32.19990415195032.00844460@hsins.uia.ac.be>
Date: Thu, 15 Apr 1999 19:50:32 +0200
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
From: David De Ridder <david.de.ridder@bitsmart.com>
Subject: Re: First attempt for LinuxPPC on a MVME2400
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <371621E6.F54F8019@fi.infn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 19:29 15-4-99 +0200, Simone Piccardi wrote:

[snip]
>Kernel panic: kernel access of bad area pc c000bbf8 lr c000c474 address
>10120 ts
>k swapper/1
>Rebooting in 180 seconds..

 Just to make sure : try ping'ing the board after the kernel has paniced
(sp?).
 It should work. (You have 180 secs to ping it ;-) 

>I tried also to start the  zimage_nfsroot-2_2.1 image, obtainig a
>similar result, that is right because I did not setup any root tree for
>the NFS.

 What do you mean with ``a similar result'' ? Does the kernel panic because
 it cannot find a root fs or does it give an other reason ? In this case too,
 try pinging the board, to verify the Ethernet interface is configured
 correctly.

Regards,

+-----------------------------------------------------------------+
  David 'Septimus' De Ridder       <david.de.ridder@bitsmart.com> 

"Gonzo   : - You'll live to regret this.
 Old man : - We intend to !"
   - 'The Muppet Show' 

+-----------------------------------------------------------------+
  


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
