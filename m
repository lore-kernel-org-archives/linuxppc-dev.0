Date: Tue, 15 Dec 1998 22:35:48 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: VALETTE Eric <valette@crf.canon.fr>
cc: cort@persephone.cs.nmt.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: changes to the kernel
In-Reply-To: <m0zo3lc-0000WVC@tri-yann.crf.canon.fr>
Message-ID: <Pine.LNX.4.04.9812152229540.30336-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 10 Dec 1998, VALETTE Eric wrote:

> Inflates returns %d... I will send a patch enabling to print decimal
> as well... NB : this bug has been reported by alois on the mailling list
> with a fix and I have reposted the fix.
> 

FYI, I've had this problem on a 604e/133 blackhawk board. I worked around
it by setting the optimization level for arch/ppc/boot to -O instead of
-O2 in the makefile.

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
