Message-ID: <3C24CFC2.6090807@embeddededge.com>
Date: Sat, 22 Dec 2001 13:24:02 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel BOOT (kernel 2.4.16)
References: <7746B3A71007.AAA6B41@hermes17.si.c-s.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


LEROY Christophe wrote:


> Can someone help me ?
> io_block_mapping(IMAP_ADDR,...) fails because mem_pieces_find() can find
> any piece.

What code are you looking at?  The io_block_mapping is simply going to
force a map_page() operation and update the PTE tables.  How do you see
mem_pieces_find() involved in this path?

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
