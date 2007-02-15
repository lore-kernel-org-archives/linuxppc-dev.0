Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 59B49DDD05
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 12:30:59 +1100 (EST)
In-Reply-To: <11714885473600-git-send-email-timur@freescale.com>
References: <11714885473600-git-send-email-timur@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8554ec6810844cd79a8ad3eb2dda33a0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: delete boot-cpu property from all DTS files
Date: Thu, 15 Feb 2007 02:30:37 +0100
To: Timur Tabi <timur@freescale.com>
Cc: Stuart Yoder <stuart.yoder@freescale.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, g.liakhovetski@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While you're at it...

> -The /cpus/PowerPC,970@0/linux,boot-cpu property is an example of a
> +The /cpus/PowerPC,970@0/64-bit property is an example of a
>  property without a value. All other properties have a value. The

s/All other properties/All other properties in this example/

I had to read this ten times before understanding what was meant :-)


Also, why is there a special header for this in the device tree
blob?  It could just have reused /chosen/cpu (with an identity
ihandle>phandle mapping perhaps) -- just like the /aliases node
could be used for aliases, instead of this new labels scheme.

Why reinvent the wheel :-)


Patch looks good of course.


Segher
