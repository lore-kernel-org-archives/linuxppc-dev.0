Message-ID: <39839A10.EB42B00C@embeddededge.com>
Date: Sat, 29 Jul 2000 22:59:28 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Martin Costabel <costabel@wanadoo.fr>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <39821DD7.ED0DA0A2@embeddededge.com>; from dan@netx4.com on	
		 Fri, Jul 28, 2000 at 07:57:11PM -0400
		 <39821DD7.ED0DA0A2@embeddededge.com>
		 <v04003a00b5a8c0b923e3@[24.66.67.194]> <v04003a01b5a8c8c70822@[24.66.67.194]> <398391FA.72980549@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel wrote:

> ??? Care to explain? What kernel are you talking about? I don't find any
> CONFIG_MAC in the kernel sources, nor any 68000 in valkyriefb.c.

I originally stated I was using the 2.4.0-test5 from BitKeeper......
The CONFIG_MAC is in some Makefiles, which causes drivers/macintosh
to be used.


> IMHO, there seems to be a lot of confusion right now with config options
> in the latest bk kernel,

So, I'm not alone here :-)?


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
