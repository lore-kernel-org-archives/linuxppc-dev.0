Subject: Re: Why not kmalloc() ??
From: Rune Torgersen <runet@innovsys.com>
To: Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <005d01c46b3e$12adf030$0301a8c0@chuck2>
References: <s0f7edc2.025@EMAIL>
	 <1089977681.27006.90.camel@kubu.opensource.se>
	 <1089979617.1055.19.camel@bng-d000218>
	 <891CFADE-D72C-11D8-B668-003065F9B7DC@embeddededge.com>
	 <005d01c46b3e$12adf030$0301a8c0@chuck2>
Content-Type: text/plain
Message-Id: <1089992535.1546.37.camel@runet>
Mime-Version: 1.0
Date: Fri, 16 Jul 2004 10:42:15 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-07-16 at 09:06, Mark Chambers wrote:
> Is there any reason to use m8xx_cpm_hostalloc() over dma_alloc_consistent()
> for a loadable driver (that is, one loaded after VM initialized)?

Yous should even be able to use kmalloc(x, GFP_KERNEL | GFP_DMA)

This works on 82xx CPU's (and is actually used as a replacement for hostalloc
on the rewritten cpm memory allocation stuff that is yet to be released)

Might not work on 8xx though...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
