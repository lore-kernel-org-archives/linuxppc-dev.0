Message-ID: <3ABA7A27.B4CC8355@intrex.net>
Date: Thu, 22 Mar 2001 17:18:15 -0500
From: Ralph Blach <rblach@intrex.net>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: frowand@mvista.com, linuxppc-embedded@lists.linuxppc.org,
	David Blythe <blythe@routefree.com>
Subject: Re: Proposed new kernel noncaching memory allocator for the 405gp
References: <3ABA1B6A.87C5FE9B@intrex.net> <3ABA5152.34E4F5B4@mvista.com> <3ABA6746.4BB8DF7@intrex.net> <3ABA6D60.46D844F3@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

No, the transmit descriptors in the USB  code are much less than a page.  Look
at ohci-usb.c
Why do a kmalloc?  And what about SCSI and it linked list?  These need bytes and
not whole pages.



Any I'll do it and submitt it .

Chip

Dan Malek wrote:

> Ralph Blach wrote:
>
> > Yes, but these allocate on a page boundry and I was thinking of something a
> > little more granular.
>
> You can only control cache behavior on page boundaries at best, and
> from the few drivers I have looked at, this is exactly what they
> expect.
>
> > Any objections?
>
> I have been listing them in previous messages.
>
>         -- Dan

--
Ralph "Chip" Blach
KF4WBK
Chapel Hill, North Carolina


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
