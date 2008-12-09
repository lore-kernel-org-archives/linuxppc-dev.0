Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B72E2DDF2E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 05:24:01 +1100 (EST)
Message-ID: <493EB7A7.7060608@freescale.com>
Date: Tue, 09 Dec 2008 12:23:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: liran raz <liranrazlinux@gmail.com>
Subject: Re: which irqflag to use with request_irq
References: <e3b3ab5c0812090800m760e2ef8p5ee2f9120fb2fce4@mail.gmail.com>
In-Reply-To: <e3b3ab5c0812090800m760e2ef8p5ee2f9120fb2fce4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

liran raz wrote:
> hi,
> 
> When using the function:
> int request_irq (unsigned int      irq,
>      irq_handler_t      handler,
>      unsigned long      irqflags,
>      const char *      devname,
>      void *      dev_id);
> 
> To connect an ISR to one of the processor's
> peripherals irq (SCC in my case).
> 
> Which value I should use for irqflags,
> from the list in: interrupt.h file.

Just pass zero (or IRQF_SHARED if the IRQ is shared, but it shouldn't be 
in this case).

-Scott
