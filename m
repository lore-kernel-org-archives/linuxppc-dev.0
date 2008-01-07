Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 9A5F7DDEBE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 01:25:35 +1100 (EST)
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com
	[128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m07EPXT2001642
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 06:25:33 -0800 (PST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Cc: 
Subject: [PATCH 0/7] Powerpc support for SBC8560 board
Date: Mon,  7 Jan 2008 09:25:25 -0500
Message-Id: <11997159321859-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a respin of the sbc8560 patches, incorporating the feedback and
suggested changes from everyone.  Changes include:

-coding style and missing of_put (Stephen Rothwell)

-minor dtc cleanups for gianfar, mdio, mpic etc. (David Gibson / Kumar Gala)

-use for_each macros in legacy_serial to improve readability, and as
groundwork for next change (me)

-convert dtc "duart" + "device-type="soc" thing to be an epld entry
listed as compatible with "localbus" -- plus add localbus as an acceptable
parent in legacy_serial (David Gibson / Scott Wood)

-rtc is now a child of the epld/localbus and does not use device_type
in the dtc, nor in the platform detection code (David Gibson)

-add CPM2 data to dts for FCC ports (on optional daughterboard) based
on the MPC8560ADS dts (me)

-add dts aliases, conversion to dts-v1 (Kumar)

Patches are as follows:

1  powerpc-use-for_each-in-legacy_serial.txt
2  powerpc-allow-localbus-compatible-serial-ports-for-console-device.txt
3  sbc8560-add-support-for-Wind-River-SBC8560-in-arch-powerpc.txt
4  sbc8560-Add-device-tree-source-for-Wind-River-SBC8560-board.txt
5  sbc8560-Convert-WRS-SBC8560-device-tree-to-v1-format.txt
6  CPM2-Make-support-for-the-CPM2-optional-on-8560-based-boards.txt
7  sbc8560-Add-default-.config-file-for-Wind-River-SBC8560.txt

Thanks again to all those who provided feedback.

Paul.
