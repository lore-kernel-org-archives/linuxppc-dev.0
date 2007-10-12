Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3684FDDEFC
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Oct 2007 01:26:25 +1000 (EST)
Message-ID: <470F90C4.1060108@freescale.com>
Date: Fri, 12 Oct 2007 10:20:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 4/4 v2] [POWERPC] Kilauea defconfig file
References: <200710111408.34207.sr@denx.de>
	<1192107771.5534.120.camel@localhost.localdomain>
	<200710111531.13022.sr@denx.de>
	<20071011201232.GD4247@loki.buserror.net>
	<1192137219.3061.2.camel@localhost.localdomain>
	<20071012032344.GG21056@localhost.localdomain>
In-Reply-To: <20071012032344.GG21056@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This is, of course, why CONFIG_DEVICE_TREE makes no real sense and
> never has: it's a per-image, not a per-configuration variable.

Enh.  It's useful.  When we have an image config file, let me know. :-)

-Scott
