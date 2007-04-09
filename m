Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62540DDF3A
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 05:11:37 +1000 (EST)
In-Reply-To: <200704091848.l39ImK6G003731@pogo.cesa.opbu.xerox.com>
References: <200704091848.l39ImK6G003731@pogo.cesa.opbu.xerox.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <818230CD-84A3-474D-B363-58DBF7770936@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx: howto request message interrupts?
Date: Mon, 9 Apr 2007 14:11:04 -0500
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2007, at 1:48 PM, Andrew Klossner wrote:

> In the Freescale linux-2.6-85xx tree, include/asm-powerpc/irq.h leads
> me to think that there's no support for message interrupts in the
> 85xx.  Am I overlooking something, or do I need to add this myself?

You have to add it yourself.  Nothing uses the message interrupts today.

- k
