Return-Path: <olh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A6B467A06
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2006 03:43:35 +1100 (EST)
Date: Mon, 27 Feb 2006 17:43:31 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: copying /sys causes fans to spin up
Message-ID: <20060227164331.GA17749@suse.de>
References: <20060227160911.GA17569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060227160911.GA17569@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Feb 27, Olaf Hering wrote:

> Ben, 
> 
> 
> some tool copies /sys, and while doing it, the fans start to spin up on
> my G5. Any idea how to fix it, other than not reading from /sys? Have to
> find the exact file.

Just 'cp -a --parents /sys /dev/shm/' will trigger this, but fans dont
spin up:

KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_STOP, state: state_addr (isr: 04)
low_i2c: Keywest got an out of state interrupt, ignoring
low_i2c: Keywest got an out of state interrupt, ignoring
low_i2c: Keywest got an out of state interrupt, ignoring
