Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EB3A67B58
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 14:08:56 +1000 (EST)
Subject: Re: [PATCH] powerpc: EOI and clear IPI fix in xics_teardown_cpu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@us.ibm.com>
In-Reply-To: <44B06756.8090301@us.ibm.com>
References: <44B05BD0.304@us.ibm.com>
	<1152409027.4128.14.camel@localhost.localdomain>
	<44B06756.8090301@us.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:08:43 +1000
Message-Id: <1152418123.4128.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Ok, Are you talking about the patch posted 
> http://ozlabs.org/pipermail/linuxppc-dev/2006-July/024350.html? Sorry, I 
> did not notice it before I posted. Yes, it is fixed passing proper ipi 
> value to desc->chip->eoi(). But, we also to need to clear IPI  in 
> xics_teardown_cpu(). 

Ok, I'll fix that too.

Ben.
