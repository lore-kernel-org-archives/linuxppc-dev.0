Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B1A767A84
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 10:48:12 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
In-Reply-To: <16886.2489.823835.17801@alkaid.it.uu.se>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	<16885.13185.849070.479328@alkaid.it.uu.se>
	<1106623515.6244.11.camel@gaston>
	<16886.2489.823835.17801@alkaid.it.uu.se>
Content-Type: text/plain
Date: Wed, 26 Jan 2005 10:47:26 +1100
Message-Id: <1106696846.6250.20.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-01-25 at 09:56 +0100, Mikael Pettersson wrote:

> On the eMac:
> /proc/sys/kernel/powersave-nap exists and contains "0".
> /proc/device-tree/cpus/PowerPC,G4/flush-on-lock exists as an empty file.

Ok, that is weird... so for some reason, Apple decided not to allow the
eMac to do NAP mode, and thus to power manage the CPU when idle...

Ben.
