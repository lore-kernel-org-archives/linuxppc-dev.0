Return-Path: <mikpe@user.it.uu.se>
Received: from aun.it.uu.se (aun.it.uu.se [130.238.12.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.srv.it.uu.se",
	Issuer "Uppsala University CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A74CC67AB1
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 21:03:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16887.27336.161685.55774@alkaid.it.uu.se>
Date: Wed, 26 Jan 2005 11:02:48 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1106696846.6250.20.camel@gaston>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
	<1106441036.5387.41.camel@gaston> <1106529935.5587.9.camel@gaston>
	<16885.13185.849070.479328@alkaid.it.uu.se>
	<1106623515.6244.11.camel@gaston>
	<16886.2489.823835.17801@alkaid.it.uu.se>
	<1106696846.6250.20.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:
 > On Tue, 2005-01-25 at 09:56 +0100, Mikael Pettersson wrote:
 > 
 > > On the eMac:
 > > /proc/sys/kernel/powersave-nap exists and contains "0".
 > > /proc/device-tree/cpus/PowerPC,G4/flush-on-lock exists as an empty file.
 > 
 > Ok, that is weird... so for some reason, Apple decided not to allow the
 > eMac to do NAP mode, and thus to power manage the CPU when idle...

I assumed it was due to the UniNorth issue that pmac_feature.c mentions.

/Mikael
