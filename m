Return-Path: <deboralh@fel.com.cn>
Received: from sina37-69.sina.com.cn (sina37-69.sina.net [202.108.37.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "D0163", Issuer "D0163" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 27FFD67E2D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 13:19:51 +1000 (EST)
Date: Tue, 2 Aug 2005 11:17:06 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
Message-Id: <20050802031951.27FFD67E2D@ozlabs.org>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: Bad Magic Number when boot linux kernel with ppcboot (PPC860
	board)
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

In message <2005-08-02 10:08:35 Baohua.WANG@alcatel-sbell.com.cn> you wrote:

>Dear All:
>  I use a PPC860 board and ELDK 3.1.1 (kernel 2.4.25) to boot the linux kernel, after I loaded it print the following messages:
>
>=> bootm 0x180000
>## Booting image at 00000000 ...
>Bad Magic Number
>=>
Please check your boot load image address.

				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-02
