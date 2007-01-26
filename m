Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C27EDE0B3
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 18:24:24 +1100 (EST)
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l0Q7OK0T000713
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:24:20 +0900 (JST)
Received: (from root@localhost) by tsb-wall.toshiba.co.jp  id l0Q7OKNt027594
	for linuxppc-dev@ozlabs.org; Fri, 26 Jan 2007 16:24:20 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l0Q7OKeG016905
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 16:24:20 +0900 (JST)
Message-Id: <200701260724.l0Q7OIBB016333@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 26 Jan 2007 16:24:46 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCHSET] libata: PATA driver
	for Celleb
Cc: jeff@garzik.org, arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear everyone.

Thank you for many useful comments.
This is the latest patchset for the PATA controller of Celleb. 

This patchset consists of
[1] add another IRQ calls (core and headers)
[2] add another IRQ calls (libata drivers)
[3] PATA driver for Celleb

And patch[3] depends on patch[1,2].

This patchset is based on the Tejun's "devres" git tree, which is
available at the followin URL.

http://htj.dyndns.org/git/?p=libata-tj.git;a=commit;h=efc6607aefe728b2721f6a0126bc527bc23eb46f


Best regards,
Akira Iguchi
