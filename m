Date: Tue, 9 Mar 2004 13:28:28 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: John Feller <JFeller@RADIOFRAMENETWORKS.COM>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DMA transfer into sk_buff - cached memory question
Message-ID: <20040309212828.GC18478@gate.ebshome.net>
References: <09EDD8D5C7874D439B2155E0359890C7E88E45@mail.redmond.radioframenetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09EDD8D5C7874D439B2155E0359890C7E88E45@mail.redmond.radioframenetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 09, 2004 at 01:02:54PM -0800, John Feller wrote:
>
> > Please, read Documentation/DMA-mapping.txt.
>
> Ah - I'm an idiot.  I had read about "pci_map_single", but it didn't occur
> to me that it could be used after memory was kmalloc'd elsewhere.  Looked at
> some existing networking code (tulip driver) to see how it is done.  The
> "pci" in the name confused me, I guess :o}

BTW, if your driver will only run on 4xx hardware you can use
consistent_* routines (PCI DMA API is implemented using them).

Take a look at drivers/net/ibm_emac for example.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
