Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 829E5B7C48
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 05:10:33 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3QJAUBu009937
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 12:10:30 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3QJKY8w017774
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 14:20:34 -0500 (CDT)
Message-ID: <4BD5E525.1000406@freescale.com>
Date: Mon, 26 Apr 2010 14:10:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
References: <479143.77686.qm@web83504.mail.sp1.yahoo.com>
In-Reply-To: <479143.77686.qm@web83504.mail.sp1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ron Madrid wrote:
> When you say current UPM code are you talking about
> fsl_upm.c?  Cause that's only for a NAND device on the
> UPM right?  If there's different code, I don't know
> where it is.

There's also arch/powerpc/sysdev/fsl_lbc.c

-Scott
