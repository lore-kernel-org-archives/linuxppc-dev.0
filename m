Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F788DE0DA
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 12:33:42 +1000 (EST)
Subject: Re: Executing from readablee, no-exec pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070706164942.GA10806@ld0162-tx32.am.freescale.net>
References: <468D68D4.4050704@freescale.com>
	<4A6D2FF2-ADD3-4D8A-ADBB-F04CAA778539@kernel.crashing.org>
	<20070706164942.GA10806@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Sat, 07 Jul 2007 12:33:32 +1000
Message-Id: <1183775612.3388.193.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Well, it means that leaving VM_READ out of the check (except where the
> hardware PTE has an exec bit) isn't really buying us anything
> security-wise (especially since the primary reason for no-exec protection
> is to avoid code injections via stack overflow, and those pages will
> usually already be present), so it doesn't hurt much to let things keep
> working.
> 
> At the least, I'd like it to keep working for a few more kernel releases
> (with a warning printed when a VM_EXEC-only test would have failed), so
> people have time to upgrade glibc.

I agree. Care to send a patch ? :-0

Ben.
