In-Reply-To: <005d01c46b3e$12adf030$0301a8c0@chuck2>
References: <s0f7edc2.025@EMAIL> <1089977681.27006.90.camel@kubu.opensource.se> <1089979617.1055.19.camel@bng-d000218> <891CFADE-D72C-11D8-B668-003065F9B7DC@embeddededge.com> <005d01c46b3e$12adf030$0301a8c0@chuck2>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9EA767D6-D75A-11D8-A208-003065F9B7DC@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Why not kmalloc() ??
Date: Fri, 16 Jul 2004 15:02:01 -0400
To: "Mark Chambers" <markc@mail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 16, 2004, at 10:06 AM, Mark Chambers wrote:

> Is there any reason to use m8xx_cpm_hostalloc() over
> dma_alloc_consistent()
> for a loadable driver (that is, one loaded after VM initialized)?

You should always use dma_alloc_conistent().  The hostalloc space
is basically a small pre-allocated non-caches space that early
initialization
functions need.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
