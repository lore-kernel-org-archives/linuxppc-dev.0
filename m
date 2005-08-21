Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50C7667FAC
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Aug 2005 07:23:56 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arthur Othieno <a.othieno@bluewin.ch>
In-Reply-To: <20050821011649.GA31839@mars>
References: <20050821011649.GA31839@mars>
Content-Type: text/plain
Date: Mon, 22 Aug 2005 07:22:41 +1000
Message-Id: <1124659361.5197.121.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: Big-endian I/O memory accessors.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-08-20 at 21:16 -0400, Arthur Othieno wrote:
> I/O memory accessors. Big-endian version. For those busses/devices
> that do export big-endian I/O memory.
> 
> Of notable relevance/reference:
> 
>    http://lwn.net/Articles/132804/
>    http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019798.html
>    http://ozlabs.org/pipermail/linuxppc-embedded/2005-August/019752.html
> 
> Signed-Off-By: Arthur Othieno <a.othieno@bluewin.ch>
> 

No, that's not correct. You need to use the in_be/out_be variants which
provide proper memory barriers.

Ben.
