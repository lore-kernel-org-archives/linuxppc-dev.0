Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B07DFDDEF6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 14:29:04 +1000 (EST)
Date: Tue, 24 Apr 2007 21:29:02 -0700 (PDT)
Message-Id: <20070424.212902.00454541.davem@davemloft.net>
To: segher@kernel.crashing.org
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: David Miller <davem@davemloft.net>
In-Reply-To: <c65c2fcf295f9b4a40292156b5258012@kernel.crashing.org>
References: <20070424.110456.124867547.davem@davemloft.net>
	<1177459651.14873.164.camel@localhost.localdomain>
	<c65c2fcf295f9b4a40292156b5258012@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Wed, 25 Apr 2007 03:03:31 +0200

> end up with the OF analogue to an MSI layer that only
> ever can work on intel compatible platforms.

Please don't use this straw-man.

These days it works perfectly fine on sparc64.
