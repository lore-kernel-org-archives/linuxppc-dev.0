Return-Path: <khali@linux-fr.org>
Received: from kellthuzad.dmz.nerim.net (smtp-dmz-232-tuesday.dmz.nerim.net
	[195.5.254.232]) by ozlabs.org (Postfix) with ESMTP id 9B0DADDDFE
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 04:32:14 +1100 (EST)
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id 5B43B26912
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 18:32:05 +0100 (CET)
Date: Tue, 6 Nov 2007 18:32:10 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
Message-ID: <20071106183210.50058019@hyperion.delvare>
In-Reply-To: <472F9086.2060606@genesi-usa.com>
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
	<9e4733910711051230w2d90a710idec3dcfc2e0f5c16@mail.gmail.com>
	<472F8267.8070106@freescale.com> <472F9086.2060606@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tjernlund <tjernlund@tjernlund.se>, i2c@lm-sensors.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 05 Nov 2007 21:52:06 +0000, Matt Sealey wrote:
> Well, all i2c devices have a chip id you can probe for (...)

This statement is completely incorrect. I2C devices do NOT have
standard ID registers. Some devices have proprietary ID registers, some
don't, it's really up to the manfacturer.

-- 
Jean Delvare
