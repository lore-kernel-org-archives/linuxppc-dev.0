Date: Sat, 06 Jan 2001 00:22:33 +0000
Subject: Re: Endianness and comparing IP's
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org
Cc: drscholl@users.sourceforge.net
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010106012137.8A8651BFBA@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote:
> IIRC IP addresses are defined as big-endian in which case they should not
> need swapping for PPC.

sorry, that's not very helpful...

more to the point is that there are a set of macros/functions designed for
this purpose (try man htons)... which avoids thinking to hard about
transferring between endian-ness of machines.

I'm not sure why the BSWAP32 is being used instead of one of the network
macros... maybe a red-herring but...

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
