Message-ID: <115601c3dabc$06d9cdf0$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Ibook G4 modem
Date: Wed, 14 Jan 2004 17:32:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Anyone knows what's the modem in the iBook G4 ? It doesn't even appear in
`lspci` nor `lsusb`.
in the device-tree, however, there's an escc node (compatible:
"chrp,es0"), with ch-a and ch-b (but they have empty "slot-names").
There's also an i2c-modem node (compatible: "minidash2").

Googling for minidash2 returns nothing...
Linuxant scripts to detect chipsets don't find anything, either.

Anyone knows something about it ?

thanks,
--
Colin
Ne disez pas disez, mais disez dites


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
