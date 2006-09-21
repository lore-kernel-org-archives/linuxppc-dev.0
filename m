Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1AEDA67BCC
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 09:22:16 +1000 (EST)
Subject: Re: [PATCH 4/11] qe_lib: Add QE I/O ports API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vbordug@ru.mvista.com>
In-Reply-To: <20060921192137.5c6af005@vitb.ru.mvista.com>
References: <F6AD7E21CDF4E145A44F61F43EE6D9399B44EF@tmnt04.transmode.se>
	<20060921192137.5c6af005@vitb.ru.mvista.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 09:22:01 +1000
Message-Id: <1158880922.26347.134.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Well, eventually this stuff aims to serve not 83xx/qe, but for cpm(1,2)-equipped stuff
> too. Apparently, we'll have to do something wise to afford that...
> 
> OTOH, this is good as a starting point I guess.

This is typical of stuff that should be in the device-tree

Ben.
