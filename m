Date: Mon, 8 Jan 2001 08:20:23 -0500 (EST)
From: alex avriette <alex@macachu.yi.org>
Reply-To: <alex@cosmo.allay.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Iain Sandoe <iain@sandoe.co.uk>, drscholl <drscholl@users.sourceforge.net>,
        "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Endianness and comparing IP's
In-Reply-To: <Pine.LNX.4.05.10101080815200.27204-100000@callisto.of.borg>
Message-ID: <Pine.LNX.4.31.0101080818490.3039-100000@macachu.ex-pressnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thank you all. The problem has been solved. solution (as per Iain and
Geert):

#define BSWAP32(c)
((((c)>>24)&0xff)|(((c)>>8)&0xff00)|(((c)<<8)&0xff0000)|((c)<<24))


thanks again.
alex


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
