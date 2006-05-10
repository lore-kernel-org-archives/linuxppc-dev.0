Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C6CFC679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 13:14:10 +1000 (EST)
Date: Tue, 9 May 2006 22:14:13 -0500
To: jschopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH] powerpc: whitespace cleanup in reg.h
Message-ID: <20060510031413.GB1794@lixom.net>
References: <20060509163419.E4E1767A04@ozlabs.org>
	<4460E0BC.4050908@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4460E0BC.4050908@austin.ibm.com>
From: Olof Johansson <olof@lixom.net>
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

On Tue, May 09, 2006 at 01:34:36PM -0500, jschopp wrote:

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
> trying to do indenting with 3 spaces instead of tabs.

It's what the rest of the file uses. It might not correspond to
CodingStyle, but it makes it easy to read.

(Now, I'm not sure it's a good idea to define the meanings of HID bits
in the global register include, but that's unrelated to the whitespace
cleanup Mikey did.)


-Olof
