Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A68FDDF2C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 22:49:26 +1000 (EST)
Message-Id: <325FF1AB-AFFA-45EE-9796-25D5004F27BB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <200806102101.20156.bzolnier@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/5] powerpc: remove mpc8xx-ide driver
Date: Thu, 12 Jun 2008 07:48:58 -0500
References: <20080610142702.354823071@arndb.de>
	<20080610142947.711491620@arndb.de>
	<200806102101.20156.bzolnier@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 10, 2008, at 2:01 PM, Bartlomiej Zolnierkiewicz wrote:

>
> Hi,
>
> On Tuesday 10 June 2008, arnd@arndb.de wrote:
>> This driver was only used by arch/ppc code and is obsolete
>> now with the move to common arch/powerpc code.
>>
>> Cc: linux-ide@vger.kernel.org
>> Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> drivers/ide/Kconfig      |   10 -
>> drivers/ide/ppc/Makefile |    1 -
>> drivers/ide/ppc/mpc8xx.c |  847  
>> ----------------------------------------------
>> 3 files changed, 0 insertions(+), 858 deletions(-)
>> delete mode 100644 drivers/ide/ppc/mpc8xx.c
>
> Thanks, applied.
>
> [ there is a couple of patches in IDE tree touching this driver so I  
> needed
>  to refresh the patch - IOW it now removes the "freshest" mpc8xx.c  
> version ]
>
> Paul/Kumar: I hope you are fine with this.

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
