From: "LEROY Christophe" <christophe.leroy@c-s.fr>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel BOOT (kernel 2.4.16)
Date: Sat, 22 Dec 2001 16:41:03 +0100
Message-ID: <7746B3A71007.AAA6B41@hermes17.si.c-s.fr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:
>LEROY Christophe wrote:
>
>
>> because it cannot find any piece for IMAP_ADDR,   as set_phys_avail()
>> only put map for RAM in phys_avail table.
>
>That's correct operation.  Only real memory is supposed to be in the
>phys_avail table.
>

Ok. So.

Can someone help me ?
io_block_mapping(IMAP_ADDR,...) fails because mem_pieces_find() can find
any piece.

How ever I cannot understand how it could find any free piece, because
mapin_ram has taken all free pieces i think.

I need some guidance here to understand what happens.

Thanks

C.Leroy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
