Date: Wed, 25 Aug 2004 22:09:13 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
References: <412CE415.6010201@mvista.com>
Subject: Re: ppc-linux still not booting on my virtexII board
Message-ID: <31448.1093464553@www29.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> (...)arch/ppc/boot/simple/embed_config.c

Oops, I skipped that code because my bootloader executes the uncompressed
kernel image (loaded at 0x00000000) without doing that stuff in the first
place. All right ;)

Thanks again,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
