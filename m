Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AD2267A46
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Feb 2005 10:39:04 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "William A.(Andy) Adamson" <andros@citi.umich.edu>
In-Reply-To: <20050204135818.E67AC1BB0C@citi.umich.edu>
References: <20050203203804.CEF201BAA9@citi.umich.edu>
	<1107472035.2363.59.camel@gaston>
	<20050204135818.E67AC1BB0C@citi.umich.edu>
Content-Type: text/plain
Date: Sat, 05 Feb 2005 10:37:49 +1100
Message-Id: <1107560269.2188.103.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: 2.6.11-rc2 on powerbook g4 - lost interrupt
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2005-02-04 at 08:58 -0500, William A.(Andy) Adamson wrote:
> hello
> 
> thanks for the response.
> 
> i disabled the cpufreq support. no change, config attached. the first 'lost 
> interrupt' message appears after the 'hda: max request size: 1024KiB'. then 
> lost interrupt messages are interleaved throughout the remaining boot, which 
> eventually hangs.
> 
> there is one 'lost interrupt, dma status: 8080' message

And going back to an earlier kernel fixes it ? Weird... I don't see
what's up there, I've tested this kernel on a bunch of powerbook's
without any such issue...

Ben.
