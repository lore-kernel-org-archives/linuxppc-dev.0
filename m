Message-Id: <200007141730.SAA17219@hyperion.valhalla.net>
Date: Fri, 14 Jul 2000 18:30:10 +0100
Subject: Upgraded utils...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
Since I'm working on 2.4.0-testx I upgraded modutils, e2fsprogs and
util-linux as suggested... (looking at the changes list).

Now I have the following behaviour:

on boot

"cannot access hardware clock by any known method"

on damaged boot partition --- 2.4.0-test4 crashes one in three times on
reboot :-(

generally heart-stopping behaviour from fsck saying that is cannot find
things and then dropping me into manual fsck...

Is there something else I need to upgrade? or remove?

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
