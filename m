Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id DDDDA679EB
	for <linuxppc-dev@ozlabs.org>; Tue, 17 May 2005 04:00:51 +1000 (EST)
Message-ID: <4288DFCB.2080208@mvista.com>
Date: Mon, 16 May 2005 11:00:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1116222720.5095.86.camel@gaston>	<7d5cfed0ee1edade8050d2c4da94b3f1@freescale.com>	<c58d28ab50872f95d4c4a751d1768513@embeddededge.com>	<1116255938.5095.133.camel@gaston>	<fe487e7a8a89e65cfefd4f5dd39a982d@embeddededge.com>
	<1116261725.5095.139.camel@gaston>
In-Reply-To: <1116261725.5095.139.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Reiser <jreiser@BitWagon.com>
Subject: Re: 2GB address space limit on 32-bit PowerPC Macintosh
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>
>series are by no mean stable. Embedded code has been rather frozen in
>the rock, I don't think it's much to ask from the appropriate maintainer
>to have a quick look at possibly upgrading their board support as well.
>

Seems reasonable to me.

>And it isn't a difficult change for most 6xx/7xx/7xxx based boards
>anyway.
>

 From a quick grep, it looks like apus, gemini, k2, lopec, pplus, prep, 
and prpmc800 are the offenders in the 6xx/7xx/74xx world.  Does anyone 
even care about the lopec and k2 anymore?

> What I'm worried about is that without some "pressure" (like
>breaking them), it will simply never be fixed...
>

Probably true...

Mark
