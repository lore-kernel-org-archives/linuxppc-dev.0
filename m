Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC7BBDE098
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:42:45 +1000 (EST)
Message-Id: <AF0B4FF7-06C8-4AF8-B1C2-23697326BDDB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <486A533B.40402@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
Date: Wed, 2 Jul 2008 02:42:39 -0500
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<200807011049.32699.laurentp@cse-semaphore.com>
	<486A533B.40402@scram.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 1, 2008, at 10:54 AM, Jochen Friedrich wrote:

> Hi Paul,
>
> On Tuesday 01 July 2008, Paul Mackerras wrote:
>
>> The following commits have been added to the master and powerpc-next
>> branches of the powerpc.git repository.  This includes patches pulled
>> from Kumar's and Josh's trees.
>
> Now that the I2C driver for CPM1/CPM2 boards is in the i2c tree, is  
> there
> any chance to get this one into 2.6.27?
>
> [POWERPC] Add i2c pins to dts and board setup
>  http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=18603

Will we always want defconfig updates to enable the driver?

- k
