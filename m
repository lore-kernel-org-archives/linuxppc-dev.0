Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F761DDE03
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 02:24:44 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7UGOa6u028824
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 09:24:37 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7UGOaox011289
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Aug 2008 11:24:36 -0500 (CDT)
Date: Sat, 30 Aug 2008 11:24:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support 36-bit
	physical
Message-ID: <20080830162435.GA30519@ld0162-tx32.am.freescale.net>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
	<C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
	<48B6CD32.2040308@freescale.com>
	<4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
	<1219963322.13162.366.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1219963322.13162.366.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 29, 2008 at 08:42:01AM +1000, Benjamin Herrenschmidt wrote:
> For the non-SMP case, I think it should be possible to optimize it. The
> only thing that can happen at interrupt time is hashing of kernel or
> vmalloc/ioremap pages, which shouldn't compete with set_pte on those
> pages, so there would be no access races there, but I may be missing
> something as it's the morning and I about just woke up :-)

Is that still true with preemptible kernels?

-Scott
