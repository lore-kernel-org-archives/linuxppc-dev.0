Date: Sat, 06 Jan 2001 23:37:24 +0000
Subject: Re: Endianness and comparing IP's
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: drscholl <drscholl@users.sourceforge.net>
Cc: drscholl <drscholl@users.sourceforge.net>,
        "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010106234445.44216E690@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> /* convert the bytes of a 32-bit integer to little endian */
> #define BSWAP32(c)
> ((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24)

 #define BSWAP32(c) \
(((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24))


will work as you expect it too... ;-)

precedence is a funny thing...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
