Return-Path: <davem@davemloft.net>
Received: from cheetah.davemloft.net
	(adsl-63-197-226-105.dsl.snfc21.pacbell.net [63.197.226.105])
	by ozlabs.org (Postfix) with ESMTP id 93F962BDA0
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Dec 2004 17:25:08 +1100 (EST)
Date: Wed, 8 Dec 2004 22:04:00 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20041208220400.71906428.davem@davemloft.net>
In-Reply-To: <1101506610.28048.23.camel@gaston>
References: <1101439228.4633.74.camel@gaston>
	<20041126200754.1123e8f8@jack.colino.net>
	<1101506610.28048.23.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: davem@redhat.com, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] sungem rework & wake on lan
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 27 Nov 2004 09:03:30 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> There is a problem with kenrel autoconfig
> (ipconfig) which doesn't schedule and should probably be fixed.

This bug should be cured in current 2.6.x sources.
