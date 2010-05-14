Return-Path: <R63238@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8C8FB7E46
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 12:16:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4E2GZYr000745
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 19:16:35 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o4E2POvB003842
	for <linuxppc-dev@ozlabs.org>; Thu, 13 May 2010 21:25:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
Date: Fri, 14 May 2010 10:16:35 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089B97531@zch01exm21.fsl.freescale.net>
In-Reply-To: <1273787172.21352.198.camel@pasglop>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com><0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
	<1273787172.21352.198.camel@pasglop>
From: "Liu Dave-R63238" <r63238@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Jin Qing-B24347 <B24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Not looking at the code right now ... but do we have the same=20
> issue on 64e ?

Aaron pointed the issue on FSL BookE.
http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-January/079738.html
