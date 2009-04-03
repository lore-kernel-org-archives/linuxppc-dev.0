Return-Path: <Qingtao.Cao@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 1602ADDDA0
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 17:02:17 +1100 (EST)
From: Harry Ciao <qingtao.cao@windriver.com>
To: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
Subject: [v1 PATCH 0/3] Add CPC925 Memory Controller EDAC drivers
Date: Fri,  3 Apr 2009 13:59:17 +0800
Message-Id: <1238738360-19839-1-git-send-email-qingtao.cao@windriver.com>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Doug and PPC developers,

This is v1 series of patches for CPC925 Memory Controller EDAC driver that works on PPC970FX. I have taken Arnd's suggestion to fold header/source/etc into one file and makes CONFIG_EDAC_CPC925 depend on CONFIG_PPC64.

Please take a look and give your comments, many thanks!

Best regards,

Harry
