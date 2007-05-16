Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 322C5DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 23:20:56 +1000 (EST)
In-Reply-To: <20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
References: <20070514163219.9d78cde0.sfr@canb.auug.org.au>
	<17993.20745.432703.238649@cargo.ozlabs.ibm.com>
	<20070516112449.9f0ae1a2.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1781cb1cf7bd5f3947efae641890456b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] remove build warnings in windfarm_core
Date: Wed, 16 May 2007 15:20:47 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	if (device_create_file(&wf_platform_device.dev, &new_ct->attr))
> +		printk(KERN_WARNING "windfarm: device_creat_file failed"
> +			"for %s\n", new_ct->name);

Needs a space in the string.


Segher
