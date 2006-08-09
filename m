Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A162A67B60
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 12:28:01 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1GAdnY-0002K3-Sa
	for linuxppc-dev@ozlabs.org; Tue, 08 Aug 2006 21:27:57 -0500
To: linuxppc-dev@ozlabs.org
Subject: Re: Perhaps git-update-server-info needs to be run
	on.../paulus/powerpc.git?
In-Reply-To: Your message of "Wed, 09 Aug 2006 12:11:50 +1000."
	<20060809121150.6ee17129.sfr@canb.auug.org.au>
References: <20060808193555.301bc229.kim.phillips@freescale.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E19D489@zch01exm23.fsl.freescale.net>
	<20060809121150.6ee17129.sfr@canb.auug.org.au>
Date: Tue, 08 Aug 2006 21:27:56 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1GAdnY-0002K3-Sa@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Stephen Rothwell mumbled:
> 
> Have you tried using the git protocol ("git://" instead of "http://")? Or
> cloning Linus tree and then fetching Paulus tree into it?

So two things: Firewall policy prevents using git native protocol,
and it sure would be nice if we could chmod +x hooks/post-update
on that tree once and for all as that issue exists every time it
is updated.

Thanks,
jdl
