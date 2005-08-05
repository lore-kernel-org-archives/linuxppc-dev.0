Return-Path: <deboralh@fel.com.cn>
Received: from sina37-69.sina.com.cn (sina37-69.sina.net [202.108.37.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "D0163", Issuer "D0163" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5D0EF67EF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 15:05:29 +1000 (EST)
Date: Fri, 5 Aug 2005 13:09:36 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
Message-Id: <20050805050529.5D0EF67EF3@ozlabs.org>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: The kernel halt after "transferring control to
	linux(0x000000)..."on HD860(MPC860SR) board kernel 2.4.25,
	and 2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, FCG WANG Baohua

In message <2005-08-05 09:11:25 Baohua.WANG@alcatel-sbell.com.cn> you wrote:

>Dear Gala:
>  I meet a problem when porting kernel  2.4.25,and 2.6.12 to a HD860 board: Whatever your config, or whatever you patch, set ppcboot enviroment, 
>  whether use ramdisk or nfs, the kernel  all display a message then halt.
>  "transferring control to linux (0x000000) ..."
Where are "transferring control to linux (0x000000) ..." ?
If are you use in The kernel 2.4.25 is from ELDK 3.1.1?
Please check you uboot.

= = = = = = = = = = = = = = = = = = = =
				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-05
