Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 85CF9DDF61
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:41:41 +1100 (EST)
Message-ID: <478F6972.9080308@scram.de>
Date: Thu, 17 Jan 2008 15:42:58 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH/RFC] [POWERPC] CPM1: implement GPIO LIB API
References: <478F4514.7030906@scram.de>
	<fa686aa40801170547q8c758dxef5aa301396f7f38@mail.gmail.com>
In-Reply-To: <fa686aa40801170547q8c758dxef5aa301396f7f38@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant,

>>  arch/powerpc/platforms/8xx/Kconfig |    2 +
>>  arch/powerpc/sysdev/commproc.c     |  162 +++++++++++++++++++++++++++++++++++-
> 
> Is this 8xx only?  Can it live in arch/powerpc/platforms/8xx?

According to the freescale docs, the GPIO ports are part of the CPM1. So I've put the
support into commproc.c (which maybe should be renamed to cpm1_common.c to match cpm2_common.c).

AFAIK, CPM1 is specific to 8xx.

Thanks,
Jochen
