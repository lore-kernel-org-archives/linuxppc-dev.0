Message-ID: <005d01c46b3e$12adf030$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <s0f7edc2.025@EMAIL> <1089977681.27006.90.camel@kubu.opensource.se> <1089979617.1055.19.camel@bng-d000218> <891CFADE-D72C-11D8-B668-003065F9B7DC@embeddededge.com>
Subject: Re: Why not kmalloc() ??
Date: Fri, 16 Jul 2004 10:06:12 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Use hostalloc
> only for those functions necesary (small serial fifos and such).
>
> Use dma_alloc_consistent() for large memory buffers that you need
> to attach to BDs, for example Ethernet buffers.  There is very little
> memory available from either dpalloc or hostalloc, and they must
> be used only when necessary.
>

Is there any reason to use m8xx_cpm_hostalloc() over dma_alloc_consistent()
for a loadable driver (that is, one loaded after VM initialized)?

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
