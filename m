Date: Fri, 7 Jul 2000 14:26:31 +1200
From: Gwyn Judd <b.judd@xtra.co.nz>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: X still locks up
Message-ID: <20000707142631.B804@thislove.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is an update on the status:

1) I tried installing the Xpmac.rev10 server that someone recommened in
the hope that that would fix the problem. Unfortunately it didn't as
five minutes ago the system locked up yet again. This seems to suggest
it may be kernel related rather than X related.

2) I recompiled my kernel wth the "Magic Sysrq" support in it. This
seems to work more or less as designed. However when the system locked
up as before the "magic sysrq" key did not work at all meaning I had to
reboot without being able to shut down properly. This suggests to me
that the kernel had itself crashed.

3) When I rebooted there was no kernel panic in the logs. This has me
puzzled. I suppose it could have crashed and not had it written out to
disk in time. On the otherhand this has happened before and each time
there is no panic.

--
Gwyn Judd (b.judd@xtra.co.nz)
f u cn rd ths, u r prbbly a lsy spllr.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
