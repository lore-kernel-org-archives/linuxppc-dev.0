Return-Path: <dan@embeddededge.com>
In-Reply-To: <20050726100500.GB28003@dmt.cnet>
References: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>
	<CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>
	<20050726100500.GB28003@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3ac21d25cf921a6c3ee68b109434fd19@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 26 Jul 2005 18:14:00 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: platform/board removal update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 26, 2005, at 6:05 AM, Marcelo Tosatti wrote:

> 8xx_io/fec.c is still using v2.4's workqueue infrastructure but other 
> than
> that its working fine.

I talked to panto about this earlier today.

> The fix will be pushed upstream ASAP.

That's OK, I'm just glad I know what it is :-)

> BTW, we should schedule 8xx_io/fec.c for removal, but before that we 
> ought to
> test all supported PHY's on the new driver.

It will be around in old kernels if we need it for reference.

Thanks, and good luck with the new job :-)

	-- Dan
