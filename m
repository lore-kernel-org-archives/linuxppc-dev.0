Message-ID: <3AB7FF89.3DC97EB2@intrex.net>
Date: Tue, 20 Mar 2001 20:10:33 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM 405 walnut platform
References: <3AB4E3BA.AF71AFE6@intrex.net> <3AB52248.D2411FF2@mvista.com> <3AB65B72.F77A0760@raleigh.ibm.com> <3AB65FCD.44826199@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Ralph Blach wrote:
>
> > Well it does.  And I recomend a new kernel interface, and Dan, I KNOW
> > YOU WILL not like THE VERY IDEA,
> > by here it is.
>
>
>
>
> > By the same token, an interface to allocate noncached memory would be
> > spiffy.
>
> That's already been done for the 8xx and 4xx ports in the kernel
> trees.
>
>         -- Dan

Yes it has, only for non cached pages.  But what propose is a new
interface like kmalloc_noncache, and kfree_noncache.

This would allow one to allocate noncached buffers for usb and SCSI work.


--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
