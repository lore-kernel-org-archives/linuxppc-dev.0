Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C9B9DDEDD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 10:07:02 +1000 (EST)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 10:06:55 +1000
Message-Id: <1213661215.8129.149.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-06-16 at 10:46 -0500, Kumar Gala wrote:
> The new e500mc core from Freescale is based on the e500v2 but with the
> following changes:
> 
> * Supports only the Enhanced Debug Architecture (DSRR0/1, etc)
> * Floating Point
> * No SPE
> * Supports lwsync
             ^^^^^^

It supports SMP ? Is tlbivax broadcast ? Is there a local form ?

Cheers,
Ben.
