Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10F5BDDED7
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jun 2008 10:20:43 +1000 (EST)
Subject: Re: [PATCH][WIP][RFC] powerpc: fixup lwsync at runtime
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <81690AB9-9D0A-4CB4-8A0A-B0D8653FECE7@kernel.crashing.org>
References: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
	<1214004193.8011.184.camel@pasglop>
	<81690AB9-9D0A-4CB4-8A0A-B0D8653FECE7@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 22 Jun 2008 10:20:36 +1000
Message-Id: <1214094036.8011.192.camel@pasglop>
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

On Sat, 2008-06-21 at 11:07 -0500, Kumar Gala wrote:
> 
> > Remind me why we want to do that ? ie. can't we just use lwsync
> > unconditionally ? It's supposed to degrade to sync on CPUs that
> don't
> > support it, or is that broken on some parts ?
> 
> I believe its broken on e500v1/v2.  However I'll double check.

An option is that if you get a program check instead, you can "fixup"
the sync from the exception too...

Ben.
