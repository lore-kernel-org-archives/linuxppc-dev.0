Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FD35DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 08:25:45 +1000 (EST)
Subject: Re: Badness at include/linux/slub_def.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <Pine.LNX.4.64.0705202304530.14522@sheep.housecafe.de>
References: <Pine.LNX.4.64.0705202304530.14522@sheep.housecafe.de>
Content-Type: text/plain
Date: Mon, 21 May 2007 08:25:36 +1000
Message-Id: <1179699936.32247.572.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-05-20 at 23:10 +0100, Christian Kujau wrote:
> hi there,
> 
> yet another[0] badness, again from this very iBook running vanilla 
> 2.6.22-rc1-git8:

Just another kmalloc(0)... report this one to the DRI folks, it's not
powerpc specific.

Cheers,
Ben.
