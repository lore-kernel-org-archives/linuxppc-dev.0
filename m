Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3BFE747D.4080908@embeddededge.com>
Date: Fri, 23 Nov 2001 11:08:29 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
References: <3BFAB960.DAA72239@mvista.com>	<15357.26322.107051.143144@cargo.ozlabs.ibm.com>	<3BFD8520.5060105@embeddededge.com> <15357.42818.227392.566129@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:


> To go with pci_map_page and pci_unmap_page.  These give you the
> ability to do DMA to highmem pages without using bounce buffers.

IIRC, there was a virt_to_bus in the code at one time, making it
unusable for highmem pages, which is why I couldn't understand
the appearance of the function.


> My preference would be to make the one set of functions work
> everywhere.

Mine, too.  I just wish this was a common concept across a variety
of our I/O interfaces.

> ....  OTOH these non-PCI devices you're talking about are
> presumably very specific to PPC embedded chips so maybe it doesn't
> matter so much.

That is always a challenge with the embedded parts.  It is often
very convenient to make the (promper, IMHO) assumption this software
isn't going to be used outside of these parts.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
