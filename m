Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 44B6EDDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 16:20:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0C5JwNU003143
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 22:19:58 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0C5Jufu014002
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 23:19:57 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Fri, 12 Jan 2007 13:19:54 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E8169E3@zch01exm20.fsl.freescale.net>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

This series of patch add support to fully comply with IEEE-754 standard
for E500/E500v2 core when hardware floating point compiling is used.

Ebony
