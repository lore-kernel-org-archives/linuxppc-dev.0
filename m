Date: Sun, 8 Oct 2000 13:58:01 -0400 (EDT)
From: Conrad H Ziesler <cziesler@umich.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: ibook ttyS0 (modem), and pppd problem, linux-2.2.17pre20ben2
Message-ID: <Pine.SOL.4.10.10010080013120.22269-100000@joust.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The first time i run pppd after reboot, everything works great.

however, if the remote host abruptly hangs up, then all future pppd
instances yield the following trace in syslog:

Oct  7 18:35:15 mwatt pppd[7318]: pppd 2.3.11 started by root, uid 0
Oct  7 18:35:19 mwatt pppd[7318]: Hangup (SIGHUP)
Oct  7 18:35:19 mwatt pppd[7318]: Connect script failed

that is, pppd aborts without ever running chat.
nothing i seem to do fixes this except reboot.

note: if pppd exits cleanly from a session, then the next time it runs has
no problem, however if the link gets disrupted, then the next (and all
future) times it fails to work.

i'm guessing there is some state in the serial driver that
doesn't get cleared in all cases, or some such...

this has been a problem in other previous kernels i have used, however
specifically, 2.2.17pre20ben2 has this problem.

thanks,
--conrad


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
