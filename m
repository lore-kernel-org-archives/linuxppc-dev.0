Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C387CDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 21:55:59 +1000 (EST)
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean-Christophe Dubois <jdubois@mc.com>
In-Reply-To: <200706071010.05172.jdubois@mc.com>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<200706050900.54022.jdubois@mc.com>
	<1181203139.4166.26.camel@concordia.ozlabs.ibm.com>
	<200706071010.05172.jdubois@mc.com>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 21:55:41 +1000
Message-Id: <1181217341.14818.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 10:10 +0200, Jean-Christophe Dubois wrote:

> The CAB (or other derived products) can be set in RC mode (via a jumper). In 
> this case the MSI could be supported. 

Is there any plan to have CABs based on AXON DD >= 2.0

I still think the right approach is to have the right properties set by
the firmware if the Axon version supports MSIs reliably. Do you see any
problem with this approach ?

Ben.
