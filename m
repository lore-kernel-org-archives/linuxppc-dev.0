Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F36C2DDEDA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 02:03:48 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m39G3eo9017434
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 09:03:40 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m39G3PJT016139
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Apr 2008 11:03:27 -0500 (CDT)
Date: Wed, 9 Apr 2008 11:03:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Message-ID: <20080409160324.GE5102@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<fa686aa40804090826j1cd5c9c2t3bd95eeb9e356a48@mail.gmail.com>
	<9258E8EF-27DF-44C4-BF73-335D9EB5DD7A@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9258E8EF-27DF-44C4-BF73-335D9EB5DD7A@kernel.crashing.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 09, 2008 at 10:27:04AM -0500, Kumar Gala wrote:
> Scott is 8xx capable of having a generic defconfig such that we can  
> build a single kernel image that will run on the various boards?

It should be.

-Scott
