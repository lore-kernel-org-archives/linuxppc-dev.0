Date: Fri, 7 Jul 2000 15:35:25 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: Dan Foster <dsf@gblx.net>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X still locks up
Message-ID: <20000707153525.A1445@thislove.dyndns.org>
References: <20000707142631.B804@thislove.dyndns.org> <20000706232259.A3148@frontiernet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000706232259.A3148@frontiernet.net>; from dsf@gblx.net on Thu, Jul 06, 2000 at 11:22:59PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 06, 2000 at 11:22:59PM -0400, Dan Foster wrote:
> Hot Diggety! Gwyn Judd was rumored to have wrote:
> >
> > Here is an update on the status:
> >
> > 1) I tried installing the Xpmac.rev10 server that someone recommened in
> > the hope that that would fix the problem. Unfortunately it didn't as
> > five minutes ago the system locked up yet again. This seems to suggest
> > it may be kernel related rather than X related.
> >
> > 2) I recompiled my kernel wth the "Magic Sysrq" support in it. This
> > seems to work more or less as designed. However when the system locked
> > up as before the "magic sysrq" key did not work at all meaning I had to
> > reboot without being able to shut down properly. This suggests to me
> > that the kernel had itself crashed.
>
> Exact same thing on my previously rock solid x86 box - only change was that
> I'd just upgraded to XFree86 4.0.1 and kernel 2.2.16, from XFree86 3.3.6 and
> kernel 2.2.13.
>
> The behavior is identical - makes me wonder if this was the mmap() bug
> that BenH previously mentioned, and if this was a cross-platform issue
> not just isolated to PPC?

Okay so you get it on x86 2.2.16 and XFree 4.01
I get it on powerpc kernel >= 2.2.15 and XFree3.3.6
Any other takers?

--
Gwyn Judd (b.judd@xtra.co.nz)
Be frank and explicit with your lawyer ... it is his business to confuse
the issue afterwards.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
