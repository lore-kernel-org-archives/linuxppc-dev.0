Date: Fri, 9 May 2003 08:15:35 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: DMA & cache coherency on 8245
Message-ID: <3EBF1042@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I,
I have written DMA functions to do software initiateds  DMA transfers on the
8245. But I have some problem with cache I think.
I allocated the buffers for DMA, configure the DMA (I use no snooping) and
launch it.
There is only part of the data that are transfered when doing mem-mem dmas or
nothing at all when doing mem-pci transfers.
I tried to use invalidate_dcache_range on the block (allocated with
__get_free_pages ) but it crashed (Exception 0X300 (memory access)).
How can I be sure of the coherency of the cache ?

Thanks,
Benoit Callebaut

------------------------------------------------------------
 Get your FREE web-based e-mail and newsgroup access at:
                http://MailAndNews.com

 Create a new mailbox, or access your existing IMAP4 or
 POP3 mailbox from anywhere with just a web browser.
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
