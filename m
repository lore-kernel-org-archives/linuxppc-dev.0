Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 31890B70CC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Sep 2010 05:53:18 +1000 (EST)
Received: from mail40-tx2 (localhost.localdomain [127.0.0.1])	by
	mail40-tx2-R.bigfish.com (Postfix) with ESMTP id 0B8C21640306	for
	<linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 19:53:14 +0000 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.250])	by
	mail40-tx2.bigfish.com (Postfix) with ESMTP id E980B1C0004E	for
	<linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 19:53:13 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8KJr9kT004241	for <linuxppc-dev@ozlabs.org>;
	Mon, 20 Sep 2010 12:53:09 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8KK5tAf002378	for <linuxppc-dev@ozlabs.org>;
	Mon, 20 Sep 2010 15:05:55 -0500 (CDT)
Message-ID: <4C97BBA4.9090401@freescale.com>
Date: Mon, 20 Sep 2010 14:53:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver
	to be compiled as a module
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
	<1284764008-19469-2-git-send-email-timur@freescale.com>
	<AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com>
	<AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com>
	<20100920193016.GA3845@zod.rchland.ibm.com>
In-Reply-To: <20100920193016.GA3845@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> I guess I don't see what you mean.  It talks about e500 but it doesn't
> say "Book-E" anywhere in that comment.  (Though I'm pretty sure that
> comment does apply to 4xx.)

That was my point.  The comment says e500, but the code is also intended for
4xx.

-- 
Timur Tabi
Linux kernel developer at Freescale
