Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4672267D9C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Oct 2006 02:06:06 +1000 (EST)
Date: Fri, 6 Oct 2006 09:06:03 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Stevens <jsteve17@yahoo.com>
Subject: Re: 440SP External Interrupt IRQ
Message-ID: <20061006160603.GB29795@gate.ebshome.net>
References: <200610060646.23125.sr@denx.de>
	<20061006102738.87758.qmail@web33402.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061006102738.87758.qmail@web33402.mail.mud.yahoo.com>
Cc: Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 06, 2006 at 03:27:38AM -0700, Jeff Stevens wrote:

[snip]

> Based on their schematics, I assume:
> IRQ Line      IRQ#
>   IRQ0        48
>   IRQ1        49
>   IRQ2        50
>   IRQ3        51
>   IRQ4        52
>   IRQ5        53

No, this mapping doesn't depend on board shematics. This is fixed, see 
"Universal Interrupt controller" chapter in user manual.

What is not fixed is mapping between IDSEL line which selects your PCI 
device and INTx# line from that PCI device to IRQx line in 440SP.

-- 
Eugene
 
