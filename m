Message-ID: <3A9A7080.995B7E00@mvista.com>
Date: Mon, 26 Feb 2001 10:04:32 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Stefano Coluccini <s.coluccini@caen.it>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: KERNELBASE at 0xa0000000
References: <NDBBIFIMCKPOADMAJOKMEEEMCPAA.s.coluccini@caen.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefano Coluccini wrote:
>
> Hi,
>   anybody knows why in the MCPN765 port KERNELBASE is at 0xa0000000 instead
> of 0xc0000000 ?

Yep.  It was a quick hack to get a system with 1GByte of memory
working.  It works fine with all other memory configurations as well.

I don't see any reason anymore (once Matt Porter dumps all of the
PReP stuff :-) that we shouldn't be able to move all kernel base
addresses to 0x80000000 or to allow 3 G user spaces.  On PowerPC,
we are simply tossing away 1G of address space that should be
utilized to make our life easier.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
