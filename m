Return-Path: <marcelo.tosatti@cyclades.com>
Date: Tue, 26 Jul 2005 07:34:49 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050726103449.GD28003@dmt.cnet>
References: <855be1bf81cc3629e58e6a23ebb50300@embeddededge.com>
	<CBF42A67-D022-4218-8624-8E40400F7C0D@freescale.com>
	<20050726100500.GB28003@dmt.cnet>
	<3ac21d25cf921a6c3ee68b109434fd19@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3ac21d25cf921a6c3ee68b109434fd19@embeddededge.com>
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

On Tue, Jul 26, 2005 at 06:14:00PM -0400, Dan Malek wrote:
> 
> On Jul 26, 2005, at 6:05 AM, Marcelo Tosatti wrote:
> 
> >8xx_io/fec.c is still using v2.4's workqueue infrastructure but other 
> >than
> >that its working fine.
> 
> I talked to panto about this earlier today.
> 
> >The fix will be pushed upstream ASAP.
> 
> That's OK, I'm just glad I know what it is :-)
> 
> >BTW, we should schedule 8xx_io/fec.c for removal, but before that we 
> >ought to
> >test all supported PHY's on the new driver.
> 
> It will be around in old kernels if we need it for reference.

Indeed.

> Thanks, and good luck with the new job :-)

Thanks! Be prepared to handle my questions :-)
