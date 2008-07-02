Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48D4EDDDE9
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:10:39 +1000 (EST)
Message-Id: <7A0E3A13-7E3D-409F-83A7-40D8092A71E9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <486B7619.4070603@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Commits added to powerpc.git master and powerpc-next branches
Date: Wed, 2 Jul 2008 10:10:22 -0500
References: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
	<200807011049.32699.laurentp@cse-semaphore.com>
	<486A533B.40402@scram.de>
	<AF0B4FF7-06C8-4AF8-B1C2-23697326BDDB@kernel.crashing.org>
	<486B7619.4070603@scram.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 7:35 AM, Jochen Friedrich wrote:

> Hi Kumar,
>
>>> any chance to get this one into 2.6.27?
>>>
>>> [POWERPC] Add i2c pins to dts and board setup
>>> http://patchwork.ozlabs.org/linuxppc/patch?person=1023&id=18603
>>
>> Will we always want defconfig updates to enable the driver?
>
> Good question. Maybe not, as the i2c bus seems to be unused on these
> boards unless someone connects some i2c devices.
>
> I'll resubmit just the booting-without-of part then.

Actually, if that's the case I'd prefer to leave the patch is as and  
just make a note about the fact that the I2C bus isn't connected to  
anything on the board in the commit message.  The code is a good  
example of setting everything else up and I'd like to have that in the  
tree.

- k
