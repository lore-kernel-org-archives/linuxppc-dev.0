Content-Type: text/plain;
  charset="iso-8859-1"
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Message-Id: <200112052146.16467@enzo.bigblue.local>
To: Corey Minyard <minyard@acm.org>
Subject: Re: Changes to PPC Linux required for GCC 3.1
Date: Wed, 5 Dec 2001 21:51:02 +0100
Cc: linuxppc-dev@lists.linuxppc.org
References: <5.1.0.14.2.20011205134825.024d8ed8@mail.lauterbach.com> <3C0E48D2.6000409@acm.org>
In-Reply-To: <3C0E48D2.6000409@acm.org>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wednesday 05 December 2001 17:18, Corey Minyard wrote:
> Franz Sirl wrote:
> > Ah, I see, I only saw this problem in aty128fb. I'll add the fix to
> > the linuxconsole CVS for 2.5.x.
>
> What about 2.4?  I'm sure people will want to compile 2.4 with gcc 3.x.

That has to go thru the usual channels.

> >> * In include/linux/sunrpc/clnt.h, I removed a bogus function declaration
> >> which was messing up inlining.
> >
> > I guess this is 3.1 specific? I don't remember problems with 3.0.x.
>
> Probably.  I've seen some other problems with GCC being fairly picky
> about declarations, and I think it's fairly new.  But the declaration
> both wrong and unnecessary.

Ah yes, I browsed this discussion on the lists.

> > What about the FAT filesystem? Is gcc-3.1 now able to correctly
> > optimize the 64bit signed divide by const into a ASHIFT+fixup?
>
> Nope.  I was going to ask about that one.  Do you have a GCC PR on this?

Nope, probably I should add one, cause I don't have time to continue with a
divdi3_32 pattern anytime soon :-(.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
