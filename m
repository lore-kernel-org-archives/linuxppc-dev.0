Return-Path: <nd@bplan-gmbh.de>
Received: from natsmtp00.rzone.de (natsmtp00.rzone.de [81.169.145.165])
	by ozlabs.org (Postfix) with ESMTP id 95AAC685DC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 17:33:54 +1000 (EST)
Received: from [192.168.0.41] (ALyon-253-1-62-186.w86-193.abo.wanadoo.fr
	[86.193.205.186])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j9P7XpZv022544
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 09:33:52 +0200 (MEST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1130225496.3946.2.camel@localhost.localdomain>
References: <1130225496.3946.2.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 25 Oct 2005 09:33:50 +0200
Message-Id: <1130225631.3970.4.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: Re: [PATCH 2.6.14-rc5 1/1] : mv643xx_eth_showsram: Added
	information message when using the SRAM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le mardi 25 octobre 2005 à 09:31 +0200, Nicolas DET a écrit :
> Added information message when using the SRAM in mv643xx_eth_probe()
> 

This is a tiny path. Nevertheless, I think it is useful to get this
information.

-
Regards
Nicolas DET
