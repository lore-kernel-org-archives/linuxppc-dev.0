From: Ernst Persson <ernstp@mac.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Random segfaults with 2.6
Date: Sat, 6 Sep 2003 16:11:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309061611.03915.ernstp@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running the latest linuxppc-2.5-benh and I'm getting a lot of random
segfaults, specially in development tools.
Emergeing in gentoo works half the time. Gcc and configure crashes, and this
never happens with 2.4.*.

Linux zapp.no-ip.com 2.6.0-test4 #5 lör sep 6 12:40:19 CEST 2003 ppc  740/750
GNU/Linux
Module                  Size  Used by
dmasound_pmac          85464  2 [unsafe]
dmasound_core          20460  3 dmasound_pmac
soundcore               9344  3 dmasound_core
i2c_core               25060  1 dmasound_pmac

Ext3 filesystem, atyfb.

I can't reproduce the crashes, they are really random.

//ernie


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
