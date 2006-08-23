Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id EB85267D12
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 20:25:08 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7NAP515029276
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 03:25:05 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k7NAP2UF024427
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 05:25:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: BogoMIPS no longer supported on PowerPC?
Date: Wed, 23 Aug 2006 18:25:31 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC209@zch01exm20.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I noticed a recent modification to __delay has changed from using empty
loops to reading timebase.  Thus, breaks the calculation of bogomips,
and makes it terribly low.  Is the bogomips no longer being supported on
powerpc arch?

- Leo
