Message-ID: <39860A50.E423F099@embeddededge.com>
Date: Mon, 31 Jul 2000 19:22:56 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <Pine.LNX.4.10.10007292003430.3886-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> Given the flexibility I was used to on m68k[*], I find this a pity as well...


Well, it looks like I opened up a big can of worms...........

I guess this is something that will get discussed as part of
"restructuring" the PowerPC source tree when we jump into 2.5.xx.
However, I need some kind of a simple solution that will help me with
the embedded processors that will no longer build in the 2.4.xx
kernel.  I know there must be some embedded Linux m68k boards that
have a similar challenge that I may be able to use for insight.

What I would like to do in the short term, is create a CONFIG_PPCMAC
that has the sole purpose of including the drivers/macintosh software,
or perhaps overload the CONFIG_ALL_PPC to do this.  Perhaps I will
look at what CONFIG_PPC really means, and not define this for embedded
boards (although this sounds wrong).

Thanks for the comments.  We'll be back :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
