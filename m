Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16A74DDF57
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 14:18:01 +1000 (EST)
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20080605094852.164f0bc7@hyperion.delvare>
References: <200806041706.21557.sr@denx.de>
	<20080604220555.658ab13e@vader.jdub.homelinux.org>
	<20080604231641.786bb2dd@lappy.seanm.ca>
	<200806050822.00797.sr@denx.de>
	<20080605094852.164f0bc7@hyperion.delvare>
Content-Type: text/plain
Date: Fri, 06 Jun 2008 14:16:23 +1000
Message-Id: <1212725783.12464.13.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>,
	Sean MacLennan <smaclennan@pikatech.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-05 at 09:48 +0200, Jean Delvare wrote:
> As far as I am concerned, it's really up to the maintainers and users
> of this platform. All I am asking for is that you do not call
> i2c_add_numbered_adapter() on an adapter with an automatically
> generated number. This function must only be used for adapter's those
> number is well defined. If an adapter doesn't have a well-defined
> number then use i2c_add_adapter() (but then you can no longer declare
> your I2C devices as part of the platform data.)

Can't we just give those things -names- instead of numbers ?

Ben.
