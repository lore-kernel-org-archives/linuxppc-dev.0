Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id DC522B7107
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Sep 2010 05:41:52 +1000 (EST)
Received: from mail138-tx2 (localhost.localdomain [127.0.0.1])	by
	mail138-tx2-R.bigfish.com (Postfix) with ESMTP id A89F3122863D	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 19:41:45 +0000 (UTC)
Received: from TX2EHSMHS006.bigfish.com (unknown [10.9.14.254])	by
	mail138-tx2.bigfish.com (Postfix) with ESMTP id DF3F61A1804D	for
	<linuxppc-dev@lists.ozlabs.org>; Thu,  9 Sep 2010 19:41:05 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o89JepPl029263	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 9 Sep 2010 12:41:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o89JsqDw006885	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 9 Sep 2010 14:54:52 -0500 (CDT)
Message-ID: <4C893842.6090009@freescale.com>
Date: Thu, 9 Sep 2010 14:40:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
References: <20100908232124.GB30291@ovro.caltech.edu>
	<1283994156.6515.6.camel@pasglop>
	<20100909025214.GA21846@ovro.caltech.edu>
	<1284001096.6515.33.camel@pasglop>
	<20100909162306.GA3496@ovro.caltech.edu>
	<20100909184446.GB3496@ovro.caltech.edu>
	<AANLkTinFu+dttvBA2qyXFxQGOTRpmWeuvmHj40BFKNCm@mail.gmail.com>
	<20100909193642.GD3496@ovro.caltech.edu>
In-Reply-To: <20100909193642.GD3496@ovro.caltech.edu>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: peterz@infradead.org, mingo@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ira W. Snyder wrote:
> As noted in another email, it appears that U-Boot puts the FDT in such a
> place that Linux overwrites it with the BSS. The CONFIG_PROVE_LOCKING=y
> option expands the BSS by a large amount, which causes the error. It
> isn't directly lockdep related.
> 
> I don't know if this is a U-Boot problem or a Linux problem. I have no
> idea how to fix the bug.

I wonder if this patch that I wrote for U-Boot will fix the problem:

http://lists.denx.de/pipermail/u-boot/2010-May/071822.html

-- 
Timur Tabi
Linux kernel developer at Freescale
