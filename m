Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A6C0767B92
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 08:16:02 +1000 (EST)
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1GEvaP-0002Au-00
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 00:16:05 +0200
Date: Mon, 21 Aug 2006 00:16:05 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: mpic_alloc() parameter change in 2.6.18-rc4 - must update users
Message-ID: <Pine.LNX.4.60.0608210008200.8128@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

have all platforms been updated for the mpic_alloc() change in -rc4 since 
then? AFAICS, at least 85xx/mpc85xx_cds.c, 86xx/mpc86xx_hpcn.c, 
embedded6xx/mpc7448_hpc2.c in -rc4 are new and are calling it with the old 
parameters. Or has it already been fixed in some tree?

Thanks
Guennadi
---
Guennadi Liakhovetski
