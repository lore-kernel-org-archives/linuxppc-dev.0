Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE555DDF77
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:47:12 +1100 (EST)
Subject: Re: [PATCH 0/4] spidernet: add support for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701171000.l0HA0jnD021501@toshiba.co.jp>
References: <200701171000.l0HA0jnD021501@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:47:32 +1100
Message-Id: <1169081253.4965.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-17 at 19:00 +0900, Ishizaki Kou wrote:
> Dear everyone,
> 
> This is a revised version of the patch set for spider_net driver
> that works on Toshiba Cell Refererence Set (aka Celleb).
> 
> This patch set is based on netdev-2.6.git#upstream.

Jens, can you give that a go on our blades see if it doesn't break
anything ? We are all at LCA here so it's a bit hard to test !

Cheers,
Ben.
