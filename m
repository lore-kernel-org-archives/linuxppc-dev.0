Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 252D3DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 13:26:52 +1100 (EST)
Subject: Re: [PATCH] IRQ assign for some PCIe devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
In-Reply-To: <49241AD7.3060201@linux.vnet.ibm.com>
References: <49241AD7.3060201@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 13:26:43 +1100
Message-Id: <1227148003.7185.185.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-19 at 11:55 -0200, Adhemerval Zanella wrote:
> 
> Fallowing a Benjamin Herrenschmidt request, I sending you a fix for IRQ 
> assign for some PCIe devices. This bug affects multiple PCIe devices 
> including Cadet-E, Squib-E, CISCO 4X SDR IB, and Knox adapters.

Thanks for tracking this down !

We'll pick it up. In the future, it would be nice if you could post
the patch inline rather than as an attachment (you may want to train
via private email to make sure you get the right settings in your
mailer to avoid damaging it since some mailers love to mangle patches)
and with the appropriate "Signed-off-by:..." line.

The patch is correct, Paul, can you pick it up ?

Cheers,
Ben.
