Date: Mon, 19 Aug 2002 20:01:40 +0200
From: Harald Welte <laforge@gnumonks.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: linuxppc-2.5 rsync tree broken
Message-ID: <20020819200140.A9590@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

The current (at least yesterday and today) linuxppc-2.5 tree at
source.mvista.com is broken.

It is totally missing the directories sound/core and drivers/usb/core.

This renders even 'make oldconfig' into a non-working state, since
the Config.in files in the respective directories cannot be found.

Fixing the tree would be appreciated quite a lot.

Thanks.

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+=
=20
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
