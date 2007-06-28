Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD92DDDF2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 11:20:41 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: ARCH=ppc or ARCH=powerpc
Date: Wed, 27 Jun 2007 20:20:28 -0500
To: Bizhan Gholikhamseh ((bgholikh)) <bgholikh@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 27, 2007, at 4:41 PM, Bizhan Gholikhamseh ((bgholikh)) wrote:

> Hi All,
> Sorry for asking this question again, I am still not clear on some  
> of the issues.
> Background:
> We have developed a custom board based on Freescale reference  
> board: MPC8555_CDS with MPC8541E processor running Linux 2.6.11 and  
> uboot 1.1.2 version.
>
> I would like to update the Linux kernel to the latest available  
> kernel 2.6.21.
> Here are my questions:
> 1- Should I use ARCH=ppc or ARCH=powerpc to build the kernel?

Move to ARCH=powerpc.

> 2- I have seen similar filenames under arch/ppc and arch/powerpc,  
> which one applies to MPC8541E?

There is support for MPC8541e in both arch/ppc & arch/powerpc.

> 3- Once I build the kernel, could I load the kernel with uboot  
> version 1.1.2 or not? if not what I should do?

I can't remember if u-boot 1.1.2 had support for the device tree or  
not.  If not you can use the cuImage target in arch/powerpc and use  
your existing u-boot. (or upgrade u-boot)

- k
