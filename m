Date: Thu, 6 Jul 2000 23:22:59 -0400
From: Dan Foster <dsf@gblx.net>
To: Gwyn Judd <b.judd@xtra.co.nz>
Cc: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X still locks up
Message-ID: <20000706232259.A3148@frontiernet.net>
References: <20000707142631.B804@thislove.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000707142631.B804@thislove.dyndns.org>; from b.judd@xtra.co.nz on Fri, Jul 07, 2000 at 02:26:31PM +1200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hot Diggety! Gwyn Judd was rumored to have wrote:
>
> Here is an update on the status:
>
> 1) I tried installing the Xpmac.rev10 server that someone recommened in
> the hope that that would fix the problem. Unfortunately it didn't as
> five minutes ago the system locked up yet again. This seems to suggest
> it may be kernel related rather than X related.
>
> 2) I recompiled my kernel wth the "Magic Sysrq" support in it. This
> seems to work more or less as designed. However when the system locked
> up as before the "magic sysrq" key did not work at all meaning I had to
> reboot without being able to shut down properly. This suggests to me
> that the kernel had itself crashed.

Exact same thing on my previously rock solid x86 box - only change was that
I'd just upgraded to XFree86 4.0.1 and kernel 2.2.16, from XFree86 3.3.6 and
kernel 2.2.13.

The behavior is identical - makes me wonder if this was the mmap() bug
that BenH previously mentioned, and if this was a cross-platform issue
not just isolated to PPC?

-Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
