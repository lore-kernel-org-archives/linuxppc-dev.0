Return-Path: <colin@colino.net>
Received: from paperstreet.colino.net (colino.net [213.41.131.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 545B42BDEB
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Dec 2004 20:12:13 +1100 (EST)
Date: Wed, 1 Dec 2004 10:11:30 +0100
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041201101130.05f71600@pirandello>
In-Reply-To: <1101891934.5592.0.camel@gaston>
References: <1101877409.5672.2.camel@gaston>
	<20041201083617.5b72a115@pirandello>
	<1101891934.5592.0.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 01 Dec 2004 at 20h12, Benjamin Herrenschmidt wrote:

Hi, 

> > Compiling that. btw, you didn't add the "&& !wol" before sungem's suspend call...
> 
> What do you mean ? the whole code block is now in !wol...

I'm just being stupid, i didn't see that :)
So much for trying to read patches before having had my coffee...

> Note that I'm still having problems with the cache ... I'm asking
> Moto/Freescale...

With which CPUs? I did notice zero problems with patch #5 (without freq scaling).

-- 
Colin
