Message-ID: <39831703.185AB483@embeddededge.com>
Date: Sat, 29 Jul 2000 13:40:19 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Tony Mantler <nicoya@apia.dhs.org>
CC: Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <39821DD7.ED0DA0A2@embeddededge.com>; from dan@netx4.com on
	 Fri, Jul 28, 2000 at 07:57:11PM -0400 <39821DD7.ED0DA0A2@embeddededge.com> <v04003a00b5a8c0b923e3@[24.66.67.194]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tony Mantler wrote:

> Add a CONFIG_PMAC maybe? I don't really object to sharing CONFIG_MAC with
> PPC, except that it would be easy to assume that CONFIG_MAC == CONFIG_MAC
> && __powerpc__, and vice versa CONFIG_MAC == CONFIG_MAC && __m68k__.

Ahhhhh....I get it.  Apologies to the m68k folks....
OK....let me think about this and work on some alternatives.  So, it
is OK to assume CONFIG_MAC implies m68k?

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
