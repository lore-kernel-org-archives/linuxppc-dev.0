Date: Thu, 27 May 1999 23:13:24 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: Tom Rini <tmrini@ntplx.net>
cc: Joel Klecker <jk@espy.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: new OF: how can we use it?
In-Reply-To: <Pine.LNX.4.05.9905271933270.31856-100000@pc.wackyland.com>
Message-ID: <Pine.LNX.4.04.9905272309360.28681-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 May 1999, Tom Rini wrote:

> 
> On Thu, 27 May 1999, Joel Klecker wrote:
> 
> > At 15:39 -0400 1999-05-27, Tom Rini wrote:
> > >On Thu, 27 May 1999, Brad Midgley wrote:
> > >> don't you think it would be a great help to the success of linux on
> > >> powermac if we could make the kind of elf binary that the new open
> > >> firmware loads?
> > >[neat ideas nusked]
> > >> what remains to be done? is the problem well understood/documented?
> > >
> > >It might be the text segments at the start.  Basically we need to see how
> > >darwin and netbsd/macppc are linked and what they do that we don't (or
> > >that we do and don't need to).  This is of coruse only my understanding,
> > >from a dozen emails w/ adrian sun (I have access to an iMac, he
> > >wants/wanted to fix it).
> > 
> > NetBSD/macppc kernels have the .note section that OF wants, 
> > Linux/powerpc kernels do not.
> > 
> > <ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch
> > /powerpc/powerpc/ofwmagic.S>
> > 
> > See also vger: linux/arch/ppc/chrpboot/{mknote.c,Makefile}.
> 
> Hmm.  So has anybody tried booting a CHRP-specific 2.3.x kernel on a B&W
> or iMac? :)

Just tried using the latest vger 'chrpboot', which makes a zImage, from a
Pmac kernel, and got 'gunzipping...'
'Default Catch 0900'  (which is the decrementer exception)

FYI, netbooting uses standard bootp and tftp 8->


> 
> ---
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
> 

> 

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
