Message-ID: <3ABA6746.4BB8DF7@intrex.net>
Date: Thu, 22 Mar 2001 15:57:42 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA5152.34E4F5B4@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank,

Yes, but these allocate on a page boundry and I was thinking of something a
little more granular.

Any objections?

Chip

Frank Rowand wrote:

> Ralph Blach wrote:
> >
>
> >
> > David Blythe wrote:
>
> > > I think something more general then pci_alloc_consistent would be
> > better
> > > for devices that are not pci based.  We are still working on getting a
> >
> > > pci OHCI usb to work with the walnut card and are running into a lot
> > of
> > > cache coherency problems.
>
> Dan Malek has provided the functions consistent_alloc(), consistent_free(),
> and consistent_sync() for uses other than PCI.  They are in linuxppc_2_5
> rev 1.446 and later (I'm not sure if they are in any earlier version).
> They are also in my active development kernel, but not yet in any kernel
> that I have put on my ftp site.
>
> -Frank
> --
> Frank Rowand <frank_rowand@mvista.com>
> MontaVista Software, Inc

--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
