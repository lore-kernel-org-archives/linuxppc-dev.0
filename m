Date: Sat, 06 Jan 2001 23:05:05 +0000
Subject: Re: Endianness and comparing IP's
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: drscholl <drscholl@users.sourceforge.net>
Cc: drscholl <drscholl@users.sourceforge.net>,
        "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010106231225.90F15E68A@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sat, Jan 6, 2001, drscholl wrote...
[...]
>> probably (but it wouldn't be difficult to check that anyway).
> Yes, I did verify that they are all unsigned int, not just relying on
> that.  :-)

hmmm. I suppose that the literals in the macro are int by definition?

> /* convert the bytes of a 32-bit integer to little endian */
> #define BSWAP32(c)
> ((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24)
>> (or are you convinced it is OK?)
> Seems to work fine under Solaris, otherwise nobody would be able to
> download anything because the IP address would be reversed.

works OK for me too under linuxppc (with default compiler options - got
anything weird specified?).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
