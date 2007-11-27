Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id EA203DDD0D
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 09:31:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] [libata] pata_platform: make probe and remove
	functions device type neutral
Date: Tue, 27 Nov 2007 23:31:33 +0100
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153900.GA14183@localhost.localdomain>
In-Reply-To: <20071127153900.GA14183@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711272331.33988.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 27 November 2007, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
