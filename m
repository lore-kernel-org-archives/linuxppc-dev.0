Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2EE3DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jun 2007 07:52:22 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A3FA@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1A3FA@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33351C82-D56D-4414-81F1-328D36A7993D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: General question on upgrading Linux version
Date: Wed, 20 Jun 2007 16:52:29 -0500
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


On Jun 20, 2007, at 16:29, Bizhan Gholikhamseh ((bgholikh)) wrote:

> Hi All,
> We are using MPC8541 processor from freescale. Our current kernel  
> version is based on 2.6.11 plus some patches provided by Freescale.  
> I would like to update our Kernel version to a more recent version.
> I would greatly appreciate if you could provide me with some  
> general guideline on how to proceed .....

You should be able to check out the latest sources from git:// 
git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

You will probably also need a newer u-boot from here:

git://www.denx.de/git/u-boot-mpc85xx.git

Please tell me if you have any problems using these.

Andy
