Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 55996DDE02
	for <linuxppc-dev@ozlabs.org>; Mon, 28 May 2007 18:23:52 +1000 (EST)
Subject: Re: Porting "prep" from ppc to powerpc.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20070528075507.GA6633@iram.es>
References: <200705252238.39819.rob@landley.net>
	<20070528075507.GA6633@iram.es>
Content-Type: text/plain
Date: Mon, 28 May 2007 18:23:34 +1000
Message-Id: <1180340614.19517.68.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-28 at 09:55 +0200, Gabriel Paubert wrote:
> I was thinking of writing a bootwrapper that would
> convert residual data to flat device tree. There
> is a lot of valuable information in the residual data,
> like the interrupt routing (which is correct if you 
> can read the spec, which is not what the code in
> arch/ppc did). 

We were wondering the other day how reliable the residual data are...

David Gibson's been toying with that too already, you should sync with
him. 

Cheers,
Ben.
