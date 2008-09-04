Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [204.133.123.27])
	by ozlabs.org (Postfix) with ESMTP id E94224778C
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:21:40 +1000 (EST)
Message-ID: <48BFFCFD.8010608@mlbassoc.com>
Date: Thu, 04 Sep 2008 09:21:33 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Hooking an IRQ on a modified mpc8349emitx board
References: <48BF15ED.4050707@silvustechnologies.com>
	<20080904144457.GA2522@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080904144457.GA2522@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Wed, Sep 03, 2008 at 03:55:41PM -0700, Oscar Takeshita wrote:
>> I've been trying to hook an IRQ on a modified mpc8349emitx board without 
>> success.
>>
>> The IRQ is hooked physically to IRQ1/GPIO2[13] on the mpc8349e. No other 
>> devices are
>> tied to this pin.
>>
>> I'm using uboot 1.2.0 and kernel 2.6.22.19.
>>
>> Do I need to have a dts entry for this interrupt in order to make
>> request_irq() succeed?
>>
>> How can I find the IRQ number? I tried probe_irq_on/off unfortunately it 
>> did not work.
>> Would it be MPC83xx_IRQ_EXT1 in arch/powerpc/include/asm/mpc83xx.h ?
>>
>> I'm new doing kernel work. Any hints appreciated.
> 
> You need to describe the IRQ in a device tree node and use
> irq_of_parse_and_map().  request_irq() takes virtual IRQ numbers.
> 
> Maybe we should put together an arch/powerpc FAQ...

That would be wonderful :-)  This could help many [of us] over these
initial speed-bumps.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
