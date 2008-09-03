Return-Path: <oscar@silvustechnologies.com>
Received: from smtpauth13.prod.mesa1.secureserver.net
	(smtpauth13.prod.mesa1.secureserver.net [64.202.165.37])
	by ozlabs.org (Postfix) with SMTP id B92CFDE164
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 09:02:23 +1000 (EST)
Message-ID: <48BF15ED.4050707@silvustechnologies.com>
Date: Wed, 03 Sep 2008 15:55:41 -0700
From: Oscar Takeshita <oscar@silvustechnologies.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Hooking an IRQ on a modified mpc8349emitx board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've been trying to hook an IRQ on a modified mpc8349emitx board without 
success.

The IRQ is hooked physically to IRQ1/GPIO2[13] on the mpc8349e. No other 
devices are
tied to this pin.

I'm using uboot 1.2.0 and kernel 2.6.22.19.

Do I need to have a dts entry for this interrupt in order to make
request_irq() succeed?

How can I find the IRQ number? I tried probe_irq_on/off unfortunately it 
did not work.
Would it be MPC83xx_IRQ_EXT1 in arch/powerpc/include/asm/mpc83xx.h ?

I'm new doing kernel work. Any hints appreciated.

Oscar

 
