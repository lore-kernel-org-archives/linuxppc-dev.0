Date: Thu, 25 Sep 2003 15:32:13 -0500 (CDT)
From: Bret Indrelee <Bret.Indrelee@qlogic.com>
Reply-To: Bret Indrelee <Bret.Indrelee@qlogic.com>
To: Eugene Surovegin <ebs@ebshome.net>
Cc: Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
In-Reply-To: <5.1.0.14.2.20030925131735.03abfab8@mail.ebshome.net>
Message-ID: <Pine.LNX.4.44.0309251526470.12966-100000@spider.ancor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 25 Sep 2003, Eugene Surovegin wrote:
> At 12:56 PM 9/25/2003, Matt Porter wrote:
> >When a buffer is allocated using the allowed methods (as defined in
> >DMA-mapping.txt) to obtain memory for use in DMA, there is
> >no guarantee that the buffer is cacheline aligned.
>
> Hmm, I don't think this is true.
>
> DMA-mapping.txt explicitly states that pci_alloc_consistent() returns
> aligned memory buffer:

It has been cut from the conversation, but I'm using streaming DMA
mappings. Specifically, pci_map_single() and pci_unmap_single().

My reading of the 2.4 DMA-mapping.txt is that use of pci_alloc_consistent()
is specific to Consistent DMA mappings. Same for the pci_pool_ interface.

-Bret

--
Bret Indrelee                 QLogic Corporation
Bret.Indrelee@qlogic.com      6321 Bury Drive, St 13, Eden Prairie, MN 55346


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
