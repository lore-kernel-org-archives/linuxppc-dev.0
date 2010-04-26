Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D97AB7D43
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 05:28:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3QJS2j3015995
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 12:28:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3QJbTDX018055
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Apr 2010 14:37:29 -0500 (CDT)
Message-ID: <4BD5E940.7000109@freescale.com>
Date: Mon, 26 Apr 2010 14:28:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: MPC8313: fsl_elbc_nand and MDR
References: <335466.44978.qm@web83505.mail.sp1.yahoo.com>
In-Reply-To: <335466.44978.qm@web83505.mail.sp1.yahoo.com>
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
> Thanks.  Although this doesn't handle programming the
> UPM, which is where my conflict is occurring.  MDR is
> used when programming the UPM.  Do you think I would
> be better served to program the UPM in U-boot and
> therefore preempt this conflict?

If you don't need to reprogram it dynamically, doing it either in u-boot 
or early in platform code is probably best.

I guess the UPM NAND code relies on U-Boot doing this?

-Scott
