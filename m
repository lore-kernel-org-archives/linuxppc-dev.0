Return-Path: <rongkai.zhan@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 61164DDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 04:36:00 +1000 (EST)
Message-ID: <469B33E8.8010105@windriver.com>
Date: Mon, 16 Jul 2007 17:01:28 +0800
From: Mark Zhan <rongkai.zhan@windriver.com>
MIME-Version: 1.0
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] 82xx: Add the support for Wind River SBC PowerQUICCII
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These 3 patches add the powerpc support of Wind River SBC PowerQUICCII.

1) Currently, some mpc82xx platform hooks in mpc82xx_ads.c are actually not specific to ads board. So the 1st patch 
makes them be shared by different 82xx boards.

2) The 2nd patch make 'cpm_uart_of_init' be able to parse SMC uart in DTS

3) The 3rd patch is the platform codes, defconfig and dts for Wind River SBC PowerQUICCII 82xx board.

Any comment is welcome.

Thanks
Mark Zhan
