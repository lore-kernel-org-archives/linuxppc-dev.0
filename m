Message-Id: <199908021746.TAA00306@piglet.cpu.lu>
Date: Mon, 2 Aug 1999 19:46:37 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: OF booting of G3-upgraded 7600?
To: linuxppc-dev@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Anybody have any idea why a 7600 upgraded with a littleJoe G3 card
can't boot through OF? I always get a 'Default Catch'.

I didn't have the leasure to analyze this further, but anyway
FAQ-o-Matic didn't offer any advice.

So far, I've been forced to boot with BootX, which works well, but is a
pain in the rear when testing new kernels (through the fact it forces me
to copy the new kernel over to MacOS).

As has been reported before, mounting HFS partitions directly can
lead to massive filesystem corruption (it happened to me as well...
while accidentaly overwriting an existing file), so I'm now moving my
kernels through a second machine via FTP....

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
