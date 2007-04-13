Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CF39DDF50
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:23:40 +1000 (EST)
Subject: Re:
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <91308d2b933e4fe8a9618aef8748b878@bga.com>
References: <91308d2b933e4fe8a9618aef8748b878@bga.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 12:23:21 +1000
Message-Id: <1176431001.5764.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-12 at 10:44 -0500, Milton Miller wrote:
> Matt sealey wrote:
> 
> +               if (cb & 0x5) { /* if controller is configured for 
> pci-native mode for both channels */
> 
> The above expression allows 1, 4, or 5 for the masked bits.  I'm 
> guessing you
> wanted to test that equal to either 5 or 0.

I think the proper test is ((cb & 5) == 5) but I can't remember for
sure.. 

Ben.
