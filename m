Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 3D1ADDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 05:51:29 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 3 Oct 2007 12:51:25 -0700
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH] PPC 85xx failure with odd memory sizes and CONFIG_HIGHMEM
Message-ID: <20071003195125.GA23881@xyzzy.farnsworth.org>
References: <20071003190140.GA19169@xyzzy.farnsworth.org>
	<DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 02:34:42PM -0500, Rune Torgersen wrote:
> > From: Dale Farnsworth
> > 
> > The CONFIG_FSL_BOOKE mmu setup code fails when CONFIG_HIGHMEM=y
> > and the 3 fixed TLB entries cannot exactly map the lowmem size.
> > Each TLB entry can map 4MB, 16MB, 64MB or 256MB, so the failure
> > is observed when the kernel lowmem size is not equal to the
> > sum of up to 3 of those values.
> 
> Does this mean you cannot run 1G of lowmem on a 85xx?

I think you can, and maybe I should have added 1GB to my list of
sizes above.  But, my 85xx system only has 256MB, so I can't test
it.

-Dale
