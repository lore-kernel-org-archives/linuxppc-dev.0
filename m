Return-Path: <bwarren@qstreams.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 75CC1DDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 May 2007 06:29:30 +1000 (EST)
Subject: Re: 83xx: requesting external interrupts
From: Ben Warren <bwarren@qstreams.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C873B42C-ABE7-4265-9EF5-15EBA9525324@kernel.crashing.org>
References: <46434C1E.3020004@cambridgebroadband.com>
	<1178816847.9018.2.camel@saruman.qstreams.net>
	<46443784.3060600@cambridgebroadband.com>
	<1178892748.9018.13.camel@saruman.qstreams.net>
	<C873B42C-ABE7-4265-9EF5-15EBA9525324@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 11 May 2007 16:29:25 -0400
Message-Id: <1178915365.9018.44.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-11 at 15:15 -0500, Kumar Gala wrote:

> 
> I assume you're code doesn't look exactly like this.  You'll need to  
> use the virq in the request_irq()... its most likely just random luck  
> if things are working and you aren't using the virq returned from  
> irq_create_mapping()
> 
> (Well its more than random luck, its because most 83xx systems only  
> have one PIC and this hw_irq # == virq)
> 
> - k

In the code that registers the ISR I do this:

virq = irq_find_mapping(NULL, MY_IRQ);
request_irq(virq ...)

Since I only have one interrupt controller, host is NULL, right?

regards,
Ben
