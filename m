Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 62D7BDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:41:35 +1100 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m0ONfXA9025006
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 15:41:33 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Cc: 
Subject: [PATCH 0/10] Support for SBC834x/8548/8560 Wind River Boards
Date: Thu, 24 Jan 2008 18:41:22 -0500
Message-Id: <12012180922447-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This series contains the patches for the Wind River SBC834x, SBC8548 and
SBC8560, grouped together for merge convenience.

Changes since previous:

sbc834x:
	- machine_device_initcall as per Kumar's recent commit 6392f184
	- remove four device_type from dts that DavidG wanted gone.
	- add of_node_put() and __initdata as per StephenR's suggestions.

sbc8548:
	- fold the dts, and conversion to dts-v1, into a single commit

sbc8560:
	- dts has localbus with 2 address cells (chipsel) and epld as child
	- UART detection legacy_serial patch separated out from 8560 patches
	- fold the dts, and conversion to dts-v1, into a single commit

I've boot tested these all on "for-2.6.25" to make sure things are sane.
Thanks again to those who have suggested improvements and changes.

Paul.
