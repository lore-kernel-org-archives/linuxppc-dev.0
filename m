Message-Id: <200007292137.WAA05449@hyperion.valhalla.net>
Date: Sat, 29 Jul 2000 22:38:04 +0100
Subject: 2.4.0-test5 :-((((
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Strange...

1/

When in "single" lower-case "a" doesn't work.  It's the only key AFAI can
tell.

Works OK once we get to init 5 and the Xserver is up (Xpmac rev 10).

2/

Second access of my HFS exchange partition locks the machine up solid - no
recovery (three finger salute required).

Bad news... makes it not sensible for me (I'm using BootX)... I'll do a diff
to -test4 (because I don't think this was happening there... not sure).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
