Date: Thu, 25 Sep 2003 13:57:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Eugene Surovegin <ebs@ebshome.net>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
Message-ID: <20030925135746.C17028@home.com>
References: <5.1.0.14.2.20030925131735.03abfab8@mail.ebshome.net> <Pine.LNX.4.44.0309251526470.12966-100000@spider.ancor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0309251526470.12966-100000@spider.ancor.com>; from Bret.Indrelee@qlogic.com on Thu, Sep 25, 2003 at 03:32:13PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 25, 2003 at 03:32:13PM -0500, Bret Indrelee wrote:
>
> On Thu, 25 Sep 2003, Eugene Surovegin wrote:
> > At 12:56 PM 9/25/2003, Matt Porter wrote:
> > >When a buffer is allocated using the allowed methods (as defined in
> > >DMA-mapping.txt) to obtain memory for use in DMA, there is
> > >no guarantee that the buffer is cacheline aligned.
> >
> > Hmm, I don't think this is true.
> >
> > DMA-mapping.txt explicitly states that pci_alloc_consistent() returns
> > aligned memory buffer:
>
> It has been cut from the conversation, but I'm using streaming DMA
> mappings. Specifically, pci_map_single() and pci_unmap_single().
>
> My reading of the 2.4 DMA-mapping.txt is that use of pci_alloc_consistent()
> is specific to Consistent DMA mappings. Same for the pci_pool_ interface.

This is correct.  All of my explanation applied to streaming DMA
mappings.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
