Message-ID: <398391FA.72980549@wanadoo.fr>
Date: Sun, 30 Jul 2000 04:24:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Tony Mantler <nicoya@apia.dhs.org>
CC: Dan Malek <dan@netx4.com>, Tom Rini <trini@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <39821DD7.ED0DA0A2@embeddededge.com>; from dan@netx4.com on	
	 Fri, Jul 28, 2000 at 07:57:11PM -0400
	 <39821DD7.ED0DA0A2@embeddededge.com>
	 <v04003a00b5a8c0b923e3@[24.66.67.194]> <v04003a01b5a8c8c70822@[24.66.67.194]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tony Mantler wrote:
>
> At 12:40 PM -0500 7/29/2000, Dan Malek wrote:
> >Tony Mantler wrote:
> >
> >> Add a CONFIG_PMAC maybe? I don't really object to sharing CONFIG_MAC with
> >> PPC, except that it would be easy to assume that CONFIG_MAC == CONFIG_MAC
> >> && __powerpc__, and vice versa CONFIG_MAC == CONFIG_MAC && __m68k__.
> >
> >Ahhhhh....I get it.  Apologies to the m68k folks....
> >OK....let me think about this and work on some alternatives.  So, it
> >is OK to assume CONFIG_MAC implies m68k?
>
> At the moment, it appears yes. via-cuda.c is a good example of this. On the
> other hand, valkyriefb.c uses __mc68000 instead, so go fig.

??? Care to explain? What kernel are you talking about? I don't find any
CONFIG_MAC in the kernel sources, nor any 68000 in valkyriefb.c.

IMHO, there seems to be a lot of confusion right now with config options
in the latest bk kernel, like you can still choose CONFIG_ADBMOUSE, but
no longer CONFIG_ADB_KEYBOARD which is needed at several places,
however.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
