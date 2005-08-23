Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2443D68077
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 08:40:49 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050823202708.GE13157@dmt.cnet>
References: <20050823202708.GE13157@dmt.cnet>
Content-Type: text/plain
Date: Wed, 24 Aug 2005 08:39:47 +1000
Message-Id: <1124836787.5189.107.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: make perfmon.o CONFIG_E500 specific
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-08-23 at 17:27 -0300, Marcelo Tosatti wrote:
> Subject says it all, there is no need to link perfmon.o on 
> sub-architectures other than CONFIG_E500.

Hrm... Nobody has an implementation for 74xx ?

Ben.
