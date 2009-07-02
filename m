Return-Path: <Frank.Prepelica@ubidyne.com>
Received: from mail.ubidyne.com (mail.ubidyne.com [212.211.133.238])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 8D69CB7133
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 18:29:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How to set DDR data bus width to 16Bit
Date: Thu, 2 Jul 2009 10:17:30 +0200
Message-ID: <29DC34A6B43468409F5A371CFE34E849D7F173@ex01.ads.ubidyne.de>
From: "Frank Prepelica" <Frank.Prepelica@ubidyne.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Does anyone knows how to set the DDR data bus width to 16Bit in linux?
I've found that=20
option in U-Boot in the MPC8313ERDB_config file. (verfied with a memory
dump of the=20
CPU register (DDR_SDRAM_CFG)  - the 16Bit DBW is set(10b) ). But after
starting=20
linux the value is set to 00b (=3Dreseverd).

We are using a customized MPC8313ERDB board.

Thanks in advance


Kind regards

Frank Prepelica
Software Design Engineer

Ubidyne GmbH
Lise-Meitner-Str.-14
89081 Ulm - Germany
