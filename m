Date: Wed, 11 Jun 2003 11:45:00 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: setting caching properties of pte entries
Message-ID: <3EEC1B10@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I,
To avoid cache problem when doing dma transfer on a MPC8245 I want to set
myself the WIMG flags of the pte entry for a mapped block of memory.
Where can I do this. I don't find the code responsible to create the pte and
to set those flags for the MPC8245.

The purpose of this is to do PowerPC initiated DMA on pre-allocated buffers.
And I have some problems with datas not well written sometime whith
copy_from_user.
Can this be related to the use of get_free_page instead of kmalloc ?

Or does someone have an idea to ensure cache coherency for the DMA transfer
without using bus snooping if possible. Like a manual management of the cache
(using flush_dcache_range and invalidate_dcache_range for example)

Thanks,
Benoit Callebaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
