Date: Thu, 27 May 1999 19:33:58 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Joel Klecker <jk@espy.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: new OF: how can we use it?
In-Reply-To: <v0420510fb3737ed08ab2@[206.163.71.146]>
Message-ID: <Pine.LNX.4.05.9905271933270.31856-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 May 1999, Joel Klecker wrote:

> At 15:39 -0400 1999-05-27, Tom Rini wrote:
> >On Thu, 27 May 1999, Brad Midgley wrote:
> >> don't you think it would be a great help to the success of linux on
> >> powermac if we could make the kind of elf binary that the new open
> >> firmware loads?
> >[neat ideas nusked]
> >> what remains to be done? is the problem well understood/documented?
> >
> >It might be the text segments at the start.  Basically we need to see how
> >darwin and netbsd/macppc are linked and what they do that we don't (or
> >that we do and don't need to).  This is of coruse only my understanding,
> >from a dozen emails w/ adrian sun (I have access to an iMac, he
> >wants/wanted to fix it).
> 
> NetBSD/macppc kernels have the .note section that OF wants, 
> Linux/powerpc kernels do not.
> 
> <ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/arch
> /powerpc/powerpc/ofwmagic.S>
> 
> See also vger: linux/arch/ppc/chrpboot/{mknote.c,Makefile}.

Hmm.  So has anybody tried booting a CHRP-specific 2.3.x kernel on a B&W
or iMac? :)

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
