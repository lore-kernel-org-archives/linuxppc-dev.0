Message-ID: <014f01c3cf82$81fc4e80$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <linuxppc-dev@lists.linuxppc.org>,
	<debian-powerpc@lists.debian.org>
Subject: Userland tool for mouse buttons emulation
Date: Wed, 31 Dec 2003 10:43:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everyone,

I once submitted a patch about mouse button emulation, and BenH
told me that this emulation shouldn't be done in the kernel but
rather by a userland tool.

I wrote a little mouseemu program to do that. It replaces the
kernel emulation (be sure to
echo 0 > /proc/sys/dev/mac_hid/mouse_button_emulation
before testing it ;-)).

You can specify a modifier+key for both middle and right buttons,
which means that you can use Command-click or Ctrl-click or whatever
you want instead of just a key.

(btw, it works only with kernel 2.6 yet).

You can download it at
http://www.geekounet.org/powerbook/files/mouseemu.tar.gz

Hoping this helps,
--
Colin
Ne disez pas disez, mais disez dites

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
