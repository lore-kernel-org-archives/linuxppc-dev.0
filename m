Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8427BDDEBA
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 20:58:24 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0C9wJY8012777
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:58:19 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0C9wKHi012109
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 18:58:20 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0C9wJ75015642
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:58:19 +0900 (JST)
Message-Id: <200701120958.l0C9wIPA026082@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 12 Jan 2007 19:00:45 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 0/4] drivers/ata: add low-level I/O calls
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear everyone,

This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
which access the taskfile registers. The idea comes from drivers/ide
IN*/OUT* calls.

As you know, these calls are unnecessary for most libata drivers.
But the Celleb PATA driver needs them to use the libata common code.
And using these calls, it is possible to remove similar code
about PIO/MMIO access.

Please give me any comments.

Best regards,
Akira Iguchi
