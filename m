Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9171E67C62
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 00:51:17 +1000 (EST)
Subject: Re: Handling machine check exception
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <452E1A1D.1050601@genesi-usa.com>
References: <20061012045943.9389.qmail@web52403.mail.yahoo.com>
	<452E1A1D.1050601@genesi-usa.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 00:51:06 +1000
Message-Id: <1160664666.4792.151.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ganesh subramonian <gun_raj@yahoo.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-12 at 12:34 +0200, Matt Sealey wrote:
> The G2 core definitely has a DAR register (SPR 19).
> 
> Look on the Freescale site for G2CORERM.pdf - this is
> your reference manual, not the one specifically for the
> 8247.

Is DAR set for a machine check ?

Ben.
