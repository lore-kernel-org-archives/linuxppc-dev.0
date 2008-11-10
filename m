Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-11.online-age.net (ext-nj2ut-11.online-age.net
	[64.14.54.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 24513DDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 23:31:33 +1100 (EST)
Received: from int-nj2ut-5.online-age.net (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by ext-nj2ut-11.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mAACVTM6008510
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 07:31:29 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by int-nj2ut-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mAACVSYl025963
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Nov 2008 07:31:29 -0500
From: Martyn Welch <martyn.welch@gefanuc.com>
Subject: [PATCH 0/2] GE Fanuc's FPGA based watchdog
To: linuxppc-dev@ozlabs.org
Date: Mon, 10 Nov 2008 12:31:19 +0000
Message-ID: <20081110123101.8608.352.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: wim@iguana.be, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series implements and enables support for the FPGA based
watchdog timers found on GE Fanuc's SBC610.

There are two identical watchdog timers at different offsets in the above
mentioned boards, however the current driver is only capable of supporting
one of them.

The watchdog timers are also capable of generating interrupts at a
user-configurable threshold, though support for this operation is currently
not supported by the driver.

-- 
Signature
