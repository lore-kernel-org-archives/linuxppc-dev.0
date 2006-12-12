Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A426A67BE6
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 16:31:33 +1100 (EST)
Subject: Re: [PATCH] ppc: fix build of DCR bits on 4xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1165900994.11914.27.camel@localhost.localdomain>
References: <1165900994.11914.27.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 16:31:27 +1100
Message-Id: <1165901487.11914.34.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-12-12 at 16:23 +1100, Benjamin Herrenschmidt wrote:
> The new dcr.c file shouldn't be compiled on arch/ppc, and dcr-low.S
> should only be built if CONFIG_PPC_DCR_NATIVE is set.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hrm... it collides with Kumar's patch, sorry, I'll send a fixed one

Ben.
