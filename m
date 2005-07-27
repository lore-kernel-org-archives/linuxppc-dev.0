Return-Path: <aris@cathedrallabs.org>
Date: Wed, 27 Jul 2005 18:46:00 -0300
From: 'Aristeu Sergio Rozanski Filho' <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050727214600.GB30557@cathedrallabs.org>
References: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>
	<CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>
	<20050726100500.GB28003@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050726100500.GB28003@dmt.cnet>
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

> 8xx_io/fec.c is still using v2.4's workqueue infrastructure but other than
> that its working fine. 
> 
> The fix will be pushed upstream ASAP.
> 
> BTW, we should schedule 8xx_io/fec.c for removal, but before that we ought to 
> test all supported PHY's on the new driver.
> 
> Aris was talking to me about this on OLS. Aris, what are the PHY's not supported
> by Panto's driver again? We should build a list of those and ask around for
> testers.
I think that with Andy Fleming's PHY abstraction layer, the best thing to be done
is change fec_8xx to use this abstraction layer and then look for
testers. what you think?

-- 
Aristeu
