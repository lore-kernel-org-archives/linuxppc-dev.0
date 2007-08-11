Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1BD4EDDE37
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 13:35:05 +1000 (EST)
Date: Fri, 10 Aug 2007 22:51:16 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: Device tree aware EMAC driver
Message-ID: <20070811035116.GA324@lixom.net>
References: <20070807062231.GB8351@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070807062231.GB8351@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 04:22:31PM +1000, David Gibson wrote:

> This driver is designed to sit alongside the old driver (it lies in
> drivers/net/ibm_emac and this one in drivers/net/ibm_newemac).  The
> old driver is left in place to support arch/ppc until arch/ppc itself
> reaches its final demise (not too long now, with luck).

I would very much prefer if the patch was provided as first a pure copy
without changes, then the actual diffs on top of that. The way it is now
is just a huge blob that's harder to review than it would otherwise be.


-Olof
