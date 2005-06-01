Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE4C7679FC
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jun 2005 08:26:47 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <20050601171555.9E86B1C00209@mwinf0808.wanadoo.fr>
References: <20050601171555.9E86B1C00209@mwinf0808.wanadoo.fr>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 08:26:25 +1000
Message-Id: <1117664786.19020.81.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Tiny patch for arch/ppc/kernel/cputable.c to properly support
	the IBM PowerPC 750CXe rev 3.1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-01 at 19:14 +0100, Nicolas DET wrote:
> Hello,
> 
> You can find enclosed a small patch to properly support the 750 CXe rev
> 3.1. Indeed, the current kernel (2.6.11.11) only supports rev 2.1 and
> ignores 3.1
> 
> It's a tiny patch: it only add an entry in the table with the correct PVR
> and name. Others values has been copied from 750CXe rev 2.1.
> 
> I succesfully patched & compiled a vanila 2.6.11.11 from kernel.org.

Is it needed ? I have it in my local tree and never actuall remembered
to actually send it :) In general, that kind of entries are really only
needed when there is a feature change...

Ben.
