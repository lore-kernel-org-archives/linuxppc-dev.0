Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id A4164B7B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 07:40:35 +1100 (EST)
Received: by ywh11 with SMTP id 11so7047223ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 12:40:33 -0800 (PST)
Message-ID: <4B312EDA.7030606@billgatliff.com>
Date: Tue, 22 Dec 2009 14:40:58 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Does gpio_to_irq() work for MPC52xx gpios?
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


Is it possible to specify an individual GPIO pin as an interrupt source
with the current MPC52xx code?

I don't see anything in mpc52xx_gpio.c that registers an interrupt
handler, which I think would be a necessary step towards demultiplexing
the GPIO interrupt event.  So I'm thinking that code to allow me to
register an interrupt handler for a specific GPIO pin just isn't there...


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
