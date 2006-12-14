Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 74A0767BFD
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 16:40:16 +1100 (EST)
Subject: Re: [PATCH] Avoid calling get_irq_server() with a real, not
	virtual irq.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1166070941.5438.53.camel@kdsk1.austin.ibm.com>
References: <1166070941.5438.53.camel@kdsk1.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 16:40:09 +1100
Message-Id: <1166074809.11914.315.camel@localhost.localdomain>
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

On Wed, 2006-12-13 at 22:35 -0600, Michal Ostrowski wrote:

> We can use default_server when masking an interrupt vector.

Is that guaranteed by PAPR ?

Ben.
