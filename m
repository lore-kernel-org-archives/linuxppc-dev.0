Return-Path: <bwarren@qstreams.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 1EAE4DDEC6
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 09:26:19 +1100 (EST)
Subject: Re: device tree / how to build/compile & use with u-boot to boot
	uImage?
From: Ben Warren <bwarren@qstreams.com>
To: "Morrison, Tom" <tmorrison@empirix.com>
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901066B2252@EMPBEDEX.empirix.com>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 17:19:38 -0500
Message-Id: <1171059578.14627.147.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom,

I feel your pain.

On Fri, 2007-02-09 at 16:55 -0500, Morrison, Tom wrote:
> All,
> 

> I've looked at the Documentation/powerpc/booting_without_of.txt, 
> and this gives an explanation of the internal parts of the dts file, 
> but it doesn't tell me how to practically pass it to the kernel 
> from u-boot (e.g.: load to memory - and use bootm xxx yyy zzz)
>  
> I am pretty darn confused about this whole thing. Can anybody point me
> to 
> a SUCCINCT explanation of the use of a dts file (and how compile and use
> 
> with u-boot to pass to kernel)?
> 

u-boot> bootm <kernel_address> <initrd_address> <dtb_address>

If you don't have an initrd, it's

u-boot> bootm <kernel_address> - <dtb_address>

Hope that's succinct enough.

Ben
