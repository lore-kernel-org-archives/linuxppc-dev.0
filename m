Return-Path: <deboralh@fel.com.cn>
Received: from fel.com.cn (unknown [210.192.120.106])
	by ozlabs.org (Postfix) with ESMTP id 485E96826D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 19:58:49 +1000 (EST)
Date: Wed, 14 Sep 2005 17:42:21 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "=?iso-8859-1?B?0OzQoc3+tcRFTUFJTA==?=" <rober@opnet.com.tw>
Message-Id: <200509141737671.SM02088@RavProxy>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: How to modify MTD driver for MX29LV320ABTC-90?
Reply-To: deboralh@fel.com.cn
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, ???

In message < 2005-09-14 14:10:17 rober@opnet.com.tw>  you wrote:

> init_tqm_mtd: chip probing count 0
> init_tqm_mtd: chip probing count 1
> TQM8xxL: No support flash chips found!
Creat yourself coder in drivers/mtd/maps

        Debora Liu
        deboralh@sinovee.com
          2005-09-14
