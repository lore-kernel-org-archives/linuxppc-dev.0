Return-Path: <jschopp@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DE2E167A00
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 04:34:47 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k49IYfmX027609
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 14:34:41 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k49IYeUi142064
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:34:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k49IYeLC029200
	for <linuxppc-dev@ozlabs.org>; Tue, 9 May 2006 12:34:40 -0600
Message-ID: <4460E0BC.4050908@austin.ibm.com>
Date: Tue, 09 May 2006 13:34:36 -0500
From: jschopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: whitespace cleanup in reg.h
References: <20060509163419.E4E1767A04@ozlabs.org>
In-Reply-To: <20060509163419.E4E1767A04@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> In reg.h we mostly have #define<space> but there are a few #define<tab>
> around.  Clean these up so we use space exclusively.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

nack

> +#define SPRN_HID6	0x3F9	/* BE HID 6 */
> +#define   HID6_LB	(0x0F<<12) /* Concurrent Large Page Modes */
> +#define   HID6_DLP	(1<<20)	/* Disable all large page modes (4K only) */
> +#define SPRN_TSC_CELL	0x399	/* Thread switch control on Cell */
> +#define   TSC_CELL_DEC_ENABLE_0	0x400000 /* Decrementer Interrupt */
> +#define   TSC_CELL_DEC_ENABLE_1	0x200000 /* Decrementer Interrupt */
> +#define   TSC_CELL_EE_ENABLE	0x100000 /* External Interrupt */
> +#define   TSC_CELL_EE_BOOST	0x080000 /* External Interrupt Boost */
> +#define SPRN_TSC 	0x3FD	/* Thread switch control on others */
> +#define SPRN_TST 	0x3FC	/* Thread switch timeout on others */

OK, the tab to space for lines like SPRN_HID6 I understand.  But then you seem to be 
trying to do indenting with 3 spaces instead of tabs.  And your values don't line up, and 
your comments don't line up.

I'm just saying, either fix the formatting right or don't fix it at all.  Moving it from 
one ugly to another ugly is not worth the trouble.
