Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95BDFDDF19
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Mar 2008 04:18:43 +1100 (EST)
Message-ID: <47E29C60.10300@freescale.com>
Date: Thu, 20 Mar 2008 12:18:24 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: Re: interrupt handlers PowerPC via GCC
References: <bf04f99c0803191706q7e3a43a3i50a1d479650a3f9d@mail.gmail.com>
In-Reply-To: <bf04f99c0803191706q7e3a43a3i50a1d479650a3f9d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Tehn Yit Chin wrote:
> Hi all,
> 
> Apologies for such a basic question. I am trying to write an ISR on a
> MPC551x. When I tried to use the interrupt attribute with
> powerpc-eabi-gcc such as
> 
> _attribute_((interrupt_handler)) foobarISR(void)
> {
> }

Assuming you're talking about an interrupt handler in Linux, you don't 
need to do anything like that.  The actual interrupt entry is assembly 
code.  Search existing drivers for "irqreturn_t" to find examples of 
what an interrupt handler looks like, and "request_irq" for how to hook 
the handler into the interrupt.

-Scott
