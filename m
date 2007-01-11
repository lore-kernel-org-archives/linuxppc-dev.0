Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD499DDDE9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 19:53:51 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0B8rkA2021680
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:53:46 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0B8rkFE023186
	for linuxppc-dev@ozlabs.org; Thu, 11 Jan 2007 17:53:46 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0B8rkZw024854
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 17:53:46 +0900 (JST)
Message-Id: <200701110853.l0B8rjXU025003@toshiba.co.jp>
MIME-Version: 1.0
Date: Thu, 11 Jan 2007 17:56:10 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 0/2] drivers/ata: PATA driver
	for Celleb
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear everyone,

This is the patchset (based on 2.6.20-rc4) for PATA controller of
Toshiba Cell reference set(Celleb). I hope this patchset will be
merged to 2.6.21, so please give me any comments.

Best regards,
Akira Iguchi
