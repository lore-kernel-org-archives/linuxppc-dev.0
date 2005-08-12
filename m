Return-Path: <deboralh@fel.com.cn>
Received: from sina37-40.sina.com.cn (sina37-40.sina.net [202.108.37.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "securemail.sina.net",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 409F567F5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 14:57:15 +1000 (EST)
Date: Fri, 12 Aug 2005 13:01:28 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "Shawn Jin" <shawnxjin@gmail.com>
Message-Id: <20050812045715.409F567F5B@ozlabs.org>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: What's wrong with the serial port?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Shawn Jin

In message <2005-08-12 06:41:21 shawnxjin@gmail.com> you wrote:

>Hi,
>
>I'm porting linux 2.6.11.4 to a custom SoC with ppc440 core. The UART
>is 16550 compatible. U-Boot is already running fine.

Please check your uboot bootargs console rate setting.

= = = = = = = = = = = = = = = = = = = =
				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-12
