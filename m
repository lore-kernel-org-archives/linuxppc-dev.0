Return-Path: <deboralh@fel.com.cn>
Received: from sina37-69.sina.com.cn (sina37-69.sina.net [202.108.37.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "D0163", Issuer "D0163" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E4D167F41
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 16:04:24 +1000 (EST)
Date: Mon, 8 Aug 2005 14:08:33 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "Wolfgang Denk" <wd@denx.de>
Message-Id: <20050808060424.8E4D167F41@ozlabs.org>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: mpc 8xx watchdog eldh-3.1.1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Wolfgang Denk 

how do I use watchdog with my userspace interface ?

this wdt_mpc8xx.c is different from standard watchdog userspace interface.
example: WDIOC_KEEPALIVE
    ioctl(fd, WDIOC_KEEPALIVE, 0);

= = = = = = = = = = = = = = = = = = = =
				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-08
