Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C25E2DDEEB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 18:41:56 +1000 (EST)
Subject: Re: [PATCH 2/3] Add hard_irq_disable()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20070510003528.395b122b.akpm@linux-foundation.org>
References: <20070510052622.3E8D5DDF4B@ozlabs.org>
	<20070509224113.cca81a24.akpm@linux-foundation.org>
	<1178778951.14928.215.camel@localhost.localdomain>
	<20070510003528.395b122b.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 10 May 2007 18:41:45 +1000
Message-Id: <1178786505.14928.225.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > What about my comment layout style ? I've been using that forever ... Or
> > do you mean I should use a function documentation style layout there ?
> 
> /* This
>  * is
>  * wrong
>  */
> 
> /*
>  * This
>  * is
>  * right
>  */

Hrm... how bad are you about that one ? I must say I prefer my style :-)

Cheers,
Ben.
