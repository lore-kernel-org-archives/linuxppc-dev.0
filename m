Date: Wed, 17 Feb 1999 10:26:37 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Renaud Dreyer <rdreyer@math.berkeley.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CD-R under Linuxppc?
In-Reply-To: <199902170512.VAA03324@fhloston>
Message-ID: <Pine.LNX.4.04.9902171025360.432-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 16 Feb 1999, Renaud Dreyer wrote:

> 
>    I was thinking of buying a CD-R drive, mainly for back-up purposes.
> Is it possible to burn CD's under any of the current Linuxppc kernels
> at this point? I'm looking at an external SCSI Sony drive. Thanks,
> 

2.1.13x worked for me, and I see no reason why 2.2.1 won't work. (you
might need to patch include/asm-ppc/shmparam.h to increase the max amount
of shared mem for cdrecord)

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
