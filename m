Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id E4C2C2BDAB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 02:54:43 +1000 (EST)
Received: from [10.1.1.102] (10.1.2.1) by mailhost.rdmcorp.com (Worldmail
	1.3.167) for linuxppc-embedded@ozlabs.org; 7 Oct 2004 12:54:42 -0400
Date: Thu, 7 Oct 2004 12:47:54 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
In-Reply-To: <Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
Message-ID: <Pine.LNX.4.60.0410071246210.5536@dell.enoriver.com>
References: <1096517265.27208.18.camel@localhost.localdomain>
	<20041007154029.GE14773@smtp.west.cox.net>
	<Pine.LNX.4.60.0410071158320.5191@dell.enoriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [PATCH] remove obsolete arch/ppc/8xx_io/uart.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 7 Oct 2004, Robert P. J. Day wrote:

> On Thu, 7 Oct 2004, Tom Rini wrote:
>
>> On Thu, Sep 30, 2004 at 06:07:45AM +0200, Andreas Oberritter wrote:
>> 
>>> Hi Dan,
>>> 
>>> this patch for linuxppc-2.5 removes the old uart driver which doesn't
>>> work since a long time and has already been replaced by
>>> drivers/serial/cpm_uart/*.
>> 
>> Can you please re-do this patch vs a linux-2.6 tree?  Thanks.
>
> at the risk of jumping on on this, this patch would be affected by the 
> changes i made to Kconfig, and i've already listed (to myself) the changes 
> that are represented by this fix.  (see previous post, in which i asked a few 
> more annoying questions. :-)
>
> if you want, i can throw together the patch for this.  as i see it, the 
> changes are
>
>  1) modify Kconfig to remove choice of "Use UART"
>  2) modify Makefile to remove inclusion of uart.o
>  3) remove uart.c entirely
>
> is that about it?

no, apparently, that's not it.  there is some significant conflict 
resolution to be done between a couple Kconfig submenus.  details to 
follow as i figure it out, provided i actually understand what i'm 
looking at.  definitely not as simple as i thought at first.

rday
