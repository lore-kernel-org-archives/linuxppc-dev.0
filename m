Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C29B1007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 04:58:53 +1100 (EST)
Received: from mail175-tx2 (localhost.localdomain [127.0.0.1])	by
	mail175-tx2-R.bigfish.com (Postfix) with ESMTP id 6CD2B7F80FD	for
	<linuxppc-dev@lists.ozlabs.org>; Mon,  1 Nov 2010 17:58:49 +0000 (UTC)
Received: from TX2EHSMHS038.bigfish.com (unknown [10.9.14.247])	by
	mail175-tx2.bigfish.com (Postfix) with ESMTP id 5611D988056	for
	<linuxppc-dev@lists.ozlabs.org>; Mon,  1 Nov 2010 17:58:49 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id oA1HwU3T008534	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 1 Nov 2010 10:58:30 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oA1HwUhg026659	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 1 Nov 2010 12:58:30 -0500 (CDT)
Date: Mon, 1 Nov 2010 12:58:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: LEROY christophe <christophe.leroy@c-s.fr>
Subject: Re: [MPC8xx] Initial MMU too low
Message-ID: <20101101125828.62e833c2@udp111988uds.am.freescale.net>
In-Reply-To: <4CCC06F8.3020506@c-s.fr>
References: <4CCC06F8.3020506@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Oct 2010 13:52:24 +0200
LEROY christophe <christophe.leroy@c-s.fr> wrote:

> Hello,
> 
> When I build a kernel with DEBUG_LOCK_ALLOC set, I get a kernel which 
> has __bss_stop above the C0800000 limit, and then I get a bad page 
> exception during the zeroize of the __bss at startup, because the 
> initial MMU only maps the first 8Mbytes.
> 
> What can I do to fix that ?

Under "Advanced setup", select "Pinned Kernel TLBs".  Ignore the "860
ONLY", it applies to all 8xx.

-Scott
