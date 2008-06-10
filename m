Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B53ADDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 16:50:34 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Free a PTE bit on ppc64 with 64K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1213070451.7957.3.camel@localhost>
References: <20080529055401.9B758DDDE7@ozlabs.org>
	<1213070451.7957.3.camel@localhost>
Content-Type: text/plain
Date: Tue, 10 Jun 2008 16:50:22 +1000
Message-Id: <1213080622.25745.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-06-10 at 14:00 +1000, Michael Ellerman wrote:
> 
> This doesn't build for CONFIG_PPC_64K_PAGES=n and
> CONFIG_PPC_HAS_HASH_64K=y, because the asm is protected by the latter
> but the header definitions are protected by the former.

Crap ! This is going to be nasty... I have to think about it

Ben.
