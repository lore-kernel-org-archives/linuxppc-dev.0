Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3644167B3A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 17:57:58 +1000 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k5U84FiH012294
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 03:04:16 -0500
Subject: Re: new irq works status (#2)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1151653855.13194.9.camel@localhost.localdomain>
References: <1151653855.13194.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 17:57:51 +1000
Message-Id: <1151654272.13194.12.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-30 at 17:50 +1000, Benjamin Herrenschmidt wrote:
> I uploaded a new version at http://gate.crashing.org/~benh/irq-WIP/
> 
> This one applies on top of a linus git checkout from today and thus
> should also apply on top of a recent powerpc.git tree. It contains
> various fixes & cleanups over the previous ones, significant fixes in
> the mpic code (mpic based pseries work now) and powermac 64 bits is
> ported over.

Note: Right now, powerpc.git might not have been updated yet to linus
latest so my patch will not apply on top of it ... oops.. that will be
fixed as soon as paulus updates powerpc.git though.

Ben.
