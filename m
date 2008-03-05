Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF99DDDEFE
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 21:45:21 +1100 (EST)
Subject: Re: [PATCH] math-emu: delete PowerPC old math-emu headers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <12047077481825-git-send-email-Yu.Liu@freescale.com>
References: <12047077481825-git-send-email-Yu.Liu@freescale.com>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 21:44:52 +1100
Message-Id: <1204713892.21545.199.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-03-05 at 17:02 +0800, Liu Yu wrote:
> Use common headers as a replacement.
> The Common headers are located in "include/math-emu/",
> they are used by multiple platforms such as s390, sparc, alpha.
> 
> As the common headers have more developers,
> they are more popular and more stable.
> 
> In fact, PowerPC old math-emu headers cannot handle float point
> exceptions exactly while the common headers can.

That sounds like an excellent idea. However, were you able to run some
kind of test suite to verify that the emulation works properly ?

Cheers,
Ben.
