From: "Chris Backas" <cbackas@rcn.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Date: Fri, 22 Dec 2000 17:22:29 -0500 (EST)
Reply-To: "Chris Backas" <cbackas@bigfoot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: 2.4.0test13 + Dual G4
Message-Id: <E149b3B-0007Wq-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

As per the advice from various list members (thanks all who responded!) regarding my random-coredumps under 2.2.18 in SMP mode, I've now upgraded to kernel 2.4.0
Test 13.  I was unable to build it myself (unresolved references in the link step that I couldn't figure out) I grabbed a pre-built SMP kernel from
ftp.linuxppc.org/users/kfukui.

The kernel worked fairly well, (and was REALLY REALLY FAST!) but something went wrong with XFree86 (4.0.1) and my screen went blank and wouldn't return.  Sooo... I
upgraded to Xfree86 4.0.2 from the same source.  Once I fixed a bad symlink that the RPM created (X linked to XPMac instead of XFree86) XFree worked again.

SO, getting to the point of the mail - with the newest kernel and newest XFree, my mysterious crashes still exist.  Mozilla Mail is the biggest culprit, nearly every time I open
it it dies.  No core, it just disappears.  This does not happen on a Uni-processor kernel.

My question is, when a program dies on an SMP kernel, but it fine under a Uni processor kernel, should I assume that the application has SMP issues and report it to the
author(s), or is it a kernel bug?

Thanks!
Chris Backas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
