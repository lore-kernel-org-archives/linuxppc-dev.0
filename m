Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0102.outbound.protection.outlook.com [157.56.110.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2CAF1A02E5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 11:30:43 +1100 (AEDT)
Message-ID: <1425515430.4698.126.camel@freescale.com>
Subject: Re: [PATCH] clk: ppc-corenet: Add support for the FMD clock
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 4 Mar 2015 18:30:30 -0600
In-Reply-To: <0E6E0DAF-6DDC-4E36-BAFE-392F1BB091FC@kernel.crashing.org>
References: <1421755411-26357-1-git-send-email-igal.liberman@freescale.com>
 <0E6E0DAF-6DDC-4E36-BAFE-392F1BB091FC@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "Igal.Liberman" <igal.liberman@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 10:02 -0600, Kumar Gala wrote:
> On Jan 20, 2015, at 6:03 AM, Igal.Liberman <igal.liberman@freescale.com> wrote:
> > +	guts_regs = of_iomap(guts, 0);
> > +	of_node_put(guts);
> > +	if (!guts_regs) {
> > +		pr_err("ioremap of GUTS node failed\n");
> > +		return -EINVAL;
> > +	}
> 
> Have you guys looked at using drivers/mfd/syscon.c for GUTS access.

Given the lack of documentation, could you explain what that file
offers?  Other than a requirement to modify existing device trees to do
something other than describe the hardware (that file won't touch
anything that isn't compatible with "syscon").

-Scott
