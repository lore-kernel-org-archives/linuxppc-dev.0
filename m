Return-Path: <xchen@sunrisetelecom.com.cn>
Received: from smtp01.east.net (smtp01.east.net [211.100.61.140])
	by ozlabs.org (Postfix) with ESMTP id 0760C67C7B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 21:03:22 +1100 (EST)
Received: from unknown (HELO xchen)
	(Authenticated?user:?xchen@sunrisetelecom.com.cn@[211.157.209.206])
	(envelope-sender <xchen@sunrisetelecom.com.cn>)
	by 0 (qmail-ldap-1.03) with SMTP
	for <linuxppc-embedded@ozlabs.org>; 7 Dec 2006 18:03:09 +0800
From: =?gb2312?B?s8LPow==?= <xchen@sunrisetelecom.com.cn>
To: <linuxppc-embedded@ozlabs.org>
Subject: When I use ichache_enable or dcache_enable in uboot or linux, it crash
Date: Thu, 7 Dec 2006 18:03:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <20061207100323.0760C67C7B@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

	In the very begin of the uboot, the dcache is disable and the icache
is enable. The code runs in flash nomarlly. Then the uboot should jump to
ram and if I don't  disable icache the uboot will crash. I can't enable the
dcache too. The more serious problem is that when I boot the linux kernel
,it will stop at init_mmu. I think it is the same reason. Please help me.

Thanks & Br,
Andy 
