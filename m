Message-Id: <200103250142.UAA76689@p2.parker.boston.ma.us>
To: Ralph Blach <rblach@intrex.net>
Cc: frowand@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp 
In-reply-to: Your message of "Thu, 22 Mar 2001 15:57:42 EST."
             <3ABA6746.4BB8DF7@intrex.net>
Date: Sat, 24 Mar 2001 20:42:34 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
>Frank,
>
>Yes, but these allocate on a page boundry and I was thinking of something a
>little more granular.
>
>Any objections?

There's a some of work going in this are on the linux usb list - check
out the recent archive.

Apparently the holy grain is the slab allocator which will allocate
non-cached memory.  There are several drivers (scsi & usb) which have
their own private versions.  Work is going on to create a generic library
which all drivers (pci and otherwise) can use...

-brad


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
