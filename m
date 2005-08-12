Return-Path: <deboralh@fel.com.cn>
Received: from sina37-40.sina.com.cn (sina37-40.sina.net [202.108.37.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "securemail.sina.net",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 765FC680C4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 15:07:22 +1000 (EST)
Date: Fri, 12 Aug 2005 13:11:38 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "Tjernlund" <tjernlund@tjernlund.se>
Message-Id: <20050812050722.765FC680C4@ozlabs.org>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx: i2c-algo-8xx - fixed timeout detection and transmission
	errors
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Tjernlund

In message <2005-08-12 01:50:45 tjernlund@tjernlund.se> you wrote:

>Try changing all
>  i2c->i2c_i2com |= 0x80;	/* Begin transmission */
>to
>  i2c->i2c_i2com |= 0x80 | 0x01;	/* Begin transmission */
>
>That should remove the need to do force_reinit(cpm) I hope.
>See http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019600.html for a litte more info.
>
>Also, I think you should remove the busy wait code. Its not needed IMHO.

update i2c_algo_8xx.c as same

= = = = = = = = = = = = = = = = = = = =
				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-12
