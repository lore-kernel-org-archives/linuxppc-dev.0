Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70EC7DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 01:51:25 +1000 (EST)
Message-Id: <DBB0FDB3-6932-4732-8A98-D0A13FC02F7C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <49F5CA09.7090607@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/86xx: clean up smp init code
Date: Mon, 27 Apr 2009 10:51:16 -0500
References: <1240421691-10193-1-git-send-email-galak@kernel.crashing.org>
	<49F064EB.5030109@gefanuc.com>
	<8AE021A6-CA3A-462E-B3AF-61A7F7D0CBA8@kernel.crashing.org>
	<49F5CA09.7090607@gefanuc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 10:06 AM, Martyn Welch wrote:

> I am using the config in the kernel ("arch/powerpc/configs/68xx/ 
> gef_ppc9a_defconfig") as is, ditto for the DTS.
>
> CONFIG_PHYS_64BIT is not set.
>
> However, looking into it a bit further 'device_type = "soc";' is  
> missing from the DTS file, so I assume get_immrbase() is returning  
> "-1".
>
> That might explain some other weird errors I recently noticed that I  
> haven't managed to find the time to track down yet...

I'm amazed this ever worked.  If you want to send me a patch for  
the .dts to add device_type = "soc" for your various .dts I'll get  
that into 2.6.30

- k
