Date: Fri, 2 Aug 2002 23:17:15 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re:  radeon 8500, ydl2.3, XFree 4.2.0
Message-Id: <20020802231715.66e91aca.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Aug 2002, R Shapiro wrote:

> Is there any way to get X going with a Radeon 8500 agp card? Ideally
> accelerated, but fbdev would be acceptable as long as the colors etc
> are reasonable (which they aren't using either the radeon or the fbdev
> driver in XFree4.2.0-6.30e).
>
> I'm running the standard YDL2.3 kernel (2.4.19-4a) and
> XFree4.2.0-6.30e. The Radeon card is being used to drive an Apple
> lcd17 through a DVIator.
>
> Related question: what's the right 'video=' kernel arg for this
> configuration? I haven't found one that works, but I can get console
> video going by blind-typing 'fbset -a 1280x1024-60'

Have you tried putting the fbset in the /etc/rc.d/rc.sysinit or rc.local,
possibly in a loop for each vt with a chvt before the fbset?  At least
it would be better than typing blind if it works.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
