Message-ID: <367A9A78.138EC0EC@jlc.net>
Date: Fri, 18 Dec 1998 13:10:00 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Magnus Damm <eramdam@kieray1.p.y.ki.era.ericsson.se>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems starting up system on a MPC823FADS
References: <199812161805.TAA14779@kieray1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Magnus Damm wrote:

> Or the ethernetdriver assumes more than the ethernetaddress.

It shouldn't need more.  I have recently ported Linux to
three different embedded boards, one that had almost no
boot rom and certainly no Ethernet set up.  All I added was
the initialization of the Etherenet address and it works
fine.

Since there is variation among the boards in the
way they connect some Ethernet control pins or the
use of external control/status registers for the PHY
part, I wonder if we don't accidently hit one of these
later and mess it up.


> I know that Dan Malek has got boot-code for the FADS, right Dan?

Should be on the linuxppc.cs.nmt.edu server.


> Why not create a board.h file?

I did :-).  It just has not yet made it to the real distribution
yet.  Almost all of the board specific CONFIG_xxx #defines
have either been removed or changed to a generic CONFIG_8xx.
All of the files now simply include "asm/mpc8xx.h", which looks
almost identical to the file you described.

I am trying to get this to work properly for all of the boards
I currently have.  I will soon just dump a tarball of my
directory on the server for everyone to see.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
