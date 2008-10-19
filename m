Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C6B30DDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 14:17:26 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.gru.flash.tv.br (Postfix) with ESMTP id 510B81C725E
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 01:17:07 -0200 (BRST)
Received: from smtp.gru.flash.tv.br ([127.0.0.1])
	by localhost (smtp.gru.flash.tv.br [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id bpSXpcxhIKE0 for <linuxppc-dev@ozlabs.org>;
	Sun, 19 Oct 2008 01:16:57 -0200 (BRST)
Received: from chagas.nectar.ath.cx (189-39-150-138.gru.flash.tv.br
	[189.39.150.138])
	by smtp.gru.flash.tv.br (Postfix) with ESMTPA id AB4CB1C71F7
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 01:16:57 -0200 (BRST)
Date: Sun, 19 Oct 2008 01:16:58 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Message-ID: <20081019031658.GC7887@ime.usp.br>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20081019025323.GA7887@ime.usp.br>
Cc: linux-kernel@vger.kernel.org, rbrito@ime.usp.br, linuxppc-dev@ozlabs.org,
	paulus@samba.org, akpm@linux-foundation.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again.

On Oct 18 2008, Rogério Brito wrote:
> And it seems that there is something not quite right for these embedded
> systems. Here is something that I get with a vanilla linkstation_defconfig:
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(...)
> I just saw that in the default config:
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> # CONFIG_PPC_CLOCK is not set
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> Maybe this should be enabled? I can iterate once more to see if this
> option would make any difference here.

Even if I enable this option, I still get the same problem as above. :-(


Regards, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
