In-Reply-To: <1089992535.1546.37.camel@runet>
References: <s0f7edc2.025@EMAIL> <1089977681.27006.90.camel@kubu.opensource.se> <1089979617.1055.19.camel@bng-d000218> <891CFADE-D72C-11D8-B668-003065F9B7DC@embeddededge.com> <005d01c46b3e$12adf030$0301a8c0@chuck2> <1089992535.1546.37.camel@runet>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <D35FFE6D-D75A-11D8-A208-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Mark Chambers <markc@mail.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Why not kmalloc() ??
Date: Fri, 16 Jul 2004 15:03:30 -0400
To: Rune Torgersen <runet@innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 16, 2004, at 11:42 AM, Rune Torgersen wrote:

> Yous should even be able to use kmalloc(x, GFP_KERNEL | GFP_DMA)

No.  This will not work properly on 8xx.

> This works on 82xx CPU's (and is actually used as a replacement for
> hostalloc
> on the rewritten cpm memory allocation stuff that is yet to be
> released)

That's because 82xx is cache coherent.  The 8xx is not.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
