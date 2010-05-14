Return-Path: <R63238@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9048BB7E26
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 10:53:20 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4E0rG8g009591
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 17:53:17 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o4E125YF014588
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 20:02:06 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
Date: Fri, 14 May 2010 08:53:13 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089B974F9@zch01exm21.fsl.freescale.net>
In-Reply-To: <0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com>
	<0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
From: "Liu Dave-R63238" <r63238@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Li Yang-R58472" <R58472@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jin Qing-B24347 <B24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I've updated the commit message to be a bit more clear on why=20
> we need to do this.

I'm curious why the _PAGE_EXEC have different definition in pte-book3e.h
and pte-fsl-booke.h?

It is UX permission in pte-book3e, but is SX permission in
pte-fsl-booke.h.

Thanks, Dave
