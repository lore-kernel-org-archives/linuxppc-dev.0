Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2720BDDDFB
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 22:35:54 +1000 (EST)
Message-ID: <486B7619.4070603@scram.de>
Date: Wed, 02 Jul 2008 14:35:37 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<200807011049.32699.laurentp@cse-semaphore.com>
	<486A533B.40402@scram.de>
	<AF0B4FF7-06C8-4AF8-B1C2-23697326BDDB@kernel.crashing.org>
In-Reply-To: <AF0B4FF7-06C8-4AF8-B1C2-23697326BDDB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

>> any chance to get this one into 2.6.27?
>>
>> [POWERPC] Add i2c pins to dts and board setup
>>  http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=18603
> 
> Will we always want defconfig updates to enable the driver?

Good question. Maybe not, as the i2c bus seems to be unused on these
boards unless someone connects some i2c devices.

I'll resubmit just the booting-without-of part then.

Thanks,
Jochen
