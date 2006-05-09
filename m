Return-Path: <hollis@penguinppc.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by ozlabs.org (Postfix) with ESMTP id 3C1FB67A45
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 05:17:42 +1000 (EST)
Subject: Re: [PATCH] powerpc: whitespace cleanup in reg.h
From: Hollis Blanchard <hollis@penguinppc.org>
To: jschopp <jschopp@austin.ibm.com>
In-Reply-To: <4460E0BC.4050908@austin.ibm.com>
References: <20060509163419.E4E1767A04@ozlabs.org>
	<4460E0BC.4050908@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 09 May 2006 13:56:31 -0500
Message-Id: <1147200991.19485.56.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-05-09 at 13:34 -0500, jschopp wrote:
> 
> > +#define SPRN_HID6	0x3F9	/* BE HID 6 */
> > +#define   HID6_LB	(0x0F<<12) /* Concurrent Large Page Modes */
> > +#define   HID6_DLP	(1<<20)	/* Disable all large page modes (4K only) */
> > +#define SPRN_TSC_CELL	0x399	/* Thread switch control on Cell */
> > +#define   TSC_CELL_DEC_ENABLE_0	0x400000 /* Decrementer Interrupt */
> > +#define   TSC_CELL_DEC_ENABLE_1	0x200000 /* Decrementer Interrupt */
> > +#define   TSC_CELL_EE_ENABLE	0x100000 /* External Interrupt */
> > +#define   TSC_CELL_EE_BOOST	0x080000 /* External Interrupt Boost */
> > +#define SPRN_TSC 	0x3FD	/* Thread switch control on others */
> > +#define SPRN_TST 	0x3FC	/* Thread switch timeout on others */
> 
> OK, the tab to space for lines like SPRN_HID6 I understand.  But then you seem to be 
> trying to do indenting with 3 spaces instead of tabs.  And your values don't line up, and 
> your comments don't line up.

The SPR numbers are indented one space. The values for each SPR follow
the SPR definition, and are indented two spaces past that. It's not
unreasonable.

I don't really care about the values or comments, but if other people do
then please use spaces for formatting (and tabs only for indenting).

-Hollis
