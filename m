Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE28A67B92
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 10:15:17 +1000 (EST)
Subject: Re: oops in snd-powermac due to snd-aoa
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060907124256.GA22928@aepfle.de>
References: <20060907124256.GA22928@aepfle.de>
Content-Type: text/plain
Date: Fri, 08 Sep 2006 10:13:03 +1000
Message-Id: <1157674383.22705.347.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 14:42 +0200, Olaf Hering wrote:
> I was playing with snd-aoa, maybe the driver would work on a G4/466.
> mv /lib/modules/*/kernel/sound/ppc/snd-powermac.ko .
> reboot
> $insmod /lib/modules/*/kernel/sound/aoa/*/*.ko
> alsamixer finds nothing.
> mv snd-powermac.ko /lib/modules/*/kernel/sound/ppc/
> $insmod snd-powermac.ko -> oops

I don't think it's due to snd-aoa ... looks like an old bogon of
snd-powermac related to the order in which snd-powermac and i2c-powermac
are loaded ....

Ben
