Date: Fri, 19 Feb 1999 22:39:12 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: Jesper Skov <jskov@cygnus.co.uk>, Gabriel Paubert <paubert@iram.es>,
        Christian Zankel <zankel@tarantel.rz.fh-muenchen.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructuring Efforts
In-Reply-To: <Pine.LNX.3.96.990218100142.6024A-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.4.04.9902192238300.22050-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Now that's kinda slick.. (And sorta scary ;)

> 
> I was just trying this out with tlbia: Use real tlbias in the kernel even
> on chips that don't do tlbia.  When on a chip that doesn't have the tlbia
> instruction take the trap and fix the code up in the trap handler (put in
> a bl soft_tlbia instead of a tlbia).  We could do something like this per
> architecture.  When doing an arch specific function trap, take the trap
> and fix it up.  The problem with that is keeping track of the myriad of
> functions we need to keep track of.
> 
> }It may be the case that none of the Amiga drivers use the same IO
> }macros as other drivers use. As I remember it, there are two set of
> }macros. But it's a long time since I looked at that, I could be wrong.
> 
> 
> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
