Date: Wed, 13 Jan 1999 20:12:35 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: a sun <asun@saul9.u.washington.edu>
cc: "David A. Gatwood" <marsmail@globegate.utm.edu>,
        linuxppc-dev@lists.linuxppc.org, bh40@calva.net
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <199901131910.LAA28570@saul9.u.washington.edu>
Message-ID: <Pine.LNX.4.04.9901132008180.926-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> well, my "oh so clever plan" is actually to use the gestalt
> information to mock up something that i pass to the m68k interrupt
> routines. presto! no more uglification of irq.c. given the
> similarities between the apus stuff and the nubus powermac stuff, i'm
> actually turning the nubus powermacs into a variant of apus for now. a
> lot of my fiddling actually ends up making some minor changes to the
> m68k code and calling that instead. 

Cort is in the process of rewriting irq.c, and I have a (somewhat large)
patch based on Corey Minyard's work which redid irq.c and most all the
machine dependant functions. You might want to take a look at this, since
I suspect it might make help reduce the 'uglification'.

it's at 

ftp://ftp.microux.com/pub/linux/linuxppc-rework-troy-2.patch.gz

Btw, I have a 7100/80 I'd like to try this on if you ever get it working
;)

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
