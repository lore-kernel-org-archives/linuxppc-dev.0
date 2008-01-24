Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E62F5DDDED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jan 2008 10:40:12 +1100 (EST)
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A9F6@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1A9F4@xmb-sjc-212.amer.cisco.com>
	<47990D51.9080803@scram.de>
	<F795765B112E7344AF36AA911279641502D1A9F6@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <389A2D5D-C1D1-469A-9436-969005D7071A@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Failed to mount rootfs
Date: Thu, 24 Jan 2008 17:39:15 -0600
To: Bizhan Gholikhamseh (bgholikh) <bgholikh@cisco.com>
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

>>
> I do not know why it is creating two chosen node. In my dts file I  
> have
> placed one empty chosen node:
> chosen{
> 	};
> If I do not do this,  I get the following error during boot process:
>
> libfdt: FDT_ERR_TRUNCATED
> Failed creating the /chosen node (0x00C00000), aborting.
>
> Any reason??

Are you adding padding to your dtb?

Try adding "-p 1024" to your dtc command line

Andy
