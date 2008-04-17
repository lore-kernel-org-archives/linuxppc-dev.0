Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 35B08DE237
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 22:46:55 +1000 (EST)
Message-ID: <480746B0.7070409@scram.de>
Date: Thu, 17 Apr 2008 14:46:40 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] powerpc: Implement GPIO LIB API on CPM2 Freescale SoC.
References: <200804171148.11593.laurentp@cse-semaphore.com>
	<200804171311.46781.laurentp@cse-semaphore.com>
	<480732C9.9080800@scram.de>
	<200804171408.46533.laurentp@cse-semaphore.com>
In-Reply-To: <200804171408.46533.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Laurent,

> BTW, what's the purpose of the shadow data register in the CPM GPIO chip 
> structure ? As the set operation is protected by a spinlock, the only use I 
> can think of is to prevent changing bits in the PDAT register for pins 
> configured as inputs. Is that correct ? If so this should be clearly 
> documented in the code.

It's for pins configured as open drain. See the discussion in:

http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050826.html

Thanks,
Jochen
