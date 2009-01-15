Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0AC3DDE2C3
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:47:54 +1100 (EST)
Date: Wed, 14 Jan 2009 22:47:55 -0800 (PST)
Message-Id: <20090114.224755.212103296.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: [PATCH 2/2] lmb: Rework lmb_dump_all() output
From: David Miller <davem@davemloft.net>
In-Reply-To: <d6b34db0a2fc1979448c0408bafb9ed33688fc54.1232001859.git.michael@ellerman.id.au>
References: <aab322f087db2ecc390ea5e224db143cf77d3067.1232001859.git.michael@ellerman.id.au>
	<d6b34db0a2fc1979448c0408bafb9ed33688fc54.1232001859.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 15 Jan 2009 17:46:02 +1100 (EST)

> The lmb_dump_all() output didn't include the RMO size, which is
> interesting on powerpc. The output was also a bit spacey and not well
> aligned, and didn't show you the end addresses.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: David S. Miller <davem@davemloft.net>

> DaveM, if you like we could make the RMO display conditional on it being
> non-zero, which would hide it on sparc presumably.

Not necessary.
