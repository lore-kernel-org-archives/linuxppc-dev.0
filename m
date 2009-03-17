Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C442DDDF00
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 01:00:07 +1100 (EST)
Message-Id: <0D92A341-7883-4339-8967-5B8B33DB099A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <49BF6D55.7020108@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Date: Tue, 17 Mar 2009 08:59:45 -0500
References: <20090316102912.10805.98764.stgit@ubuntu8041.localdomain>
	<20090316103048.10805.15368.stgit@ubuntu8041.localdomain>
	<20090317013918.GA9643@yookeroo.seuss>
	<49BF6D55.7020108@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 17, 2009, at 4:28 AM, Martyn Welch wrote:

>>>
>>> +		i2c1: i2c@3000 {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +			compatible = "fsl-i2c";
>> This should list include a compatible string specific to the
>> particular SoC model before the general name.
>
> The documentation seems to suggest to use "fsl-i2c". Should it be  
> like this?:
>
> compatible = "fsl,mpc8641d-i2c", fsl-i2c";

in theory it should be, in practice don't bother.

- k
