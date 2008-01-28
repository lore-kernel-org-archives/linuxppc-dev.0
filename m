Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id F13FDDDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 08:01:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [NET]: Remove PowerPC code from fec.c
Date: Mon, 28 Jan 2008 22:01:17 +0100
References: <4799F349.9090102@scram.de> <E1JIQpQ-0006Xj-RR@faramir.fjphome.nl>
	<479A087F.5010305@scram.de>
In-Reply-To: <479A087F.5010305@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801282201.18658.arnd@arndb.de>
Cc: linux-m68k@vger.kernel.org, netdev@vger.kernel.org,
	Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org,
	geert@linux-m68k.org, gerg@uclinux.org, scottwood@freescale.com,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 January 2008, Jochen Friedrich wrote:
> Maybe the wording should be changed to:
> 
> This driver is now only used on ColdFire (m68knommu) processors. Conditional
> PowerPC code has been removed.
> 

How about adding a pointer to the driver that is now used on powerpc,
for the people that are looking in here?

	Arnd <><
