Message-ID: <39659E42.28063140@student.ethz.ch>
Date: Fri, 07 Jul 2000 11:09:22 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Gwyn Judd <b.judd@xtra.co.nz>
CC: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: X still locks up
References: <20000707142631.B804@thislove.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gwyn Judd wrote:
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
>
> 3) When I rebooted there was no kernel panic in the logs. This has me
> puzzled. I suppose it could have crashed and not had it written out to
> disk in time. On the otherhand this has happened before and each time
> there is no panic.

All these things may also indicate a hardware lockup - let's not hope so...


Michel


--
The computer revolution is over. The computers won.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
