Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8208068734
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 10:09:32 +1100 (EST)
Date: Thu, 17 Nov 2005 17:07:01 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: David Updegraff <dave@cray.com>
In-Reply-To: <437CFB43.4060400@cray.com>
Message-ID: <Pine.LNX.4.44.0511171706060.15752-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: gianfar generic PHY assumptions.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 17 Nov 2005, David Updegraff wrote:
> Hi.
> 
> This patch lets gianfar work on 83xx (or 85xx??) boards that have 
> Generic PHYs on them that do _NOT_ happen to have an IRQ line wired to 
> external_15.  Surely reasonable that if we can't ID the PHY that its 
> probably not irq-wired the Freescale-ADS "way"...
> 
> It was critical for us; perhaps usefull for others.


The way PHYs are handle in 2.6.15 is completely different and the patch 
is not valid against the current tree.

- kumar
