Return-Path: <ebony.zhu@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CBB73DDFA9
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 21:00:53 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0TA0quc003797
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 03:00:52 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0TA0oI6008411
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 04:00:51 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
Date: Mon, 29 Jan 2007 18:00:49 +0800
Message-ID: <32F3CC26D4DAC44E8ECD07155727A46E85D9D7@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E816B9C@zch01exm20.fsl.freescale.net>
	<2C8EB4AF-97B2-40F5-8112-0CEE6E3D4D42@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6E4@zch01exm20.fsl.freescale.net>
	<A85281E5-1E9C-4938-8940-CF696C3C5174@kernel.crashing.org>
	<32F3CC26D4DAC44E8ECD07155727A46E85D6EF@zch01exm20.fsl.freescale.net>
	<F8DCDEDE-C060-458D-8E04-EA4C1EE2B2EE@kernel.crashing.org>
From: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

I think enabling SPEFSCR[FINXE] or SPEFSCR[FRMC]=3D0b10/0b11 to enable =
FP
round interrupt will cause the exception occurring very often, which
will dramatically decrease the performance of SPE instructions. Do you
think putting an option in menuconfig to let user choose whether to
enable FP round simulation is a reasonable idea?

Thanks.

Ebony=20
