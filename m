Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C6D3DDFB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jun 2007 13:14:27 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A436@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1A436@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DB7AE966-6E5C-4BD5-9F93-ACC9B74489F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: cuImage question
Date: Thu, 28 Jun 2007 22:14:23 -0500
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


On Jun 28, 2007, at 4:54 PM, Bizhan Gholikhamseh ((bgholikh)) wrote:

> Hi All,
> I am kind of new to the concept of "cuImage" and I am not able to  
> find any info on the net(?).
>
> We are using older version of the uboot: 1.1.2. I have compiled the  
> latest kernel from git tree for
> MPC8541E from freescale.
>
> I would appreciate any hints on how to use 'cuImage" to load this  
> image with our legacy uboot version?

Take a look at arch/powerpc/boot/ and the Kconfig DEVICE_TREE option.

- k
