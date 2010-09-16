Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 1DF531007D8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 07:39:19 +1000 (EST)
Received: from mail18-tx2 (localhost.localdomain [127.0.0.1])	by
	mail18-tx2-R.bigfish.com (Postfix) with ESMTP id 55D00B40158	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 21:39:16 +0000 (UTC)
Received: from TX2EHSMHS008.bigfish.com (unknown [10.9.14.253])	by
	mail18-tx2.bigfish.com (Postfix) with ESMTP id F3D841468052	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 21:39:15 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8GLdEKV006693	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 14:39:14 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8GLrSdE013329	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 16:53:28 -0500 (CDT)
Date: Thu, 16 Sep 2010 16:39:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Chris Friesen <chris.friesen@genband.com>
Subject: Re: linux support for freescale e5500 core?
Message-ID: <20100916163911.6255d359@schlenkerla.am.freescale.net>
In-Reply-To: <4C9278CD.10607@genband.com>
References: <4C9278CD.10607@genband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Sep 2010 14:06:37 -0600
Chris Friesen <chris.friesen@genband.com> wrote:

> We're looking at maybe doing some work with an e5500-based system.  Is
> there any support existing/planned for this core?

Check with whoever you'd be getting the hardware from about a BSP.

And yes, it should be supported upstream at some point.

> Also, do we know what the cache line size is--we have some legacy apps
> that assume 32-byte.

The cache line is 64 bytes.  As with e500mc, there is a "dcbz32" mode
for compatibility, though you probably lose much of the performance
benefit of dcbz, and it might upset other software that properly checks
for the cache line size but doesn't use dcbzl.

-Scott
