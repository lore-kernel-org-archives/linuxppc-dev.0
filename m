Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 584C1DDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 21:01:57 +1100 (EST)
Message-ID: <47A833FD.4040904@scram.de>
Date: Tue, 05 Feb 2008 11:01:33 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH 1/1] [PPC] 8xx swap bug-fix
References: <20080201181003.a3daf6ed.kim.phillips@freescale.com>
	<47A45269.7080403@scram.de>
	<20080204182421.GA3930@loki.buserror.net>
	<200802050946.21292.yur@emcraft.com>
In-Reply-To: <200802050946.21292.yur@emcraft.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Yuri,

> Does anybody use swap with some of the 8xx-based boards supported in 
> powerpc branch ?

modded DBox2 boxes do. Unfortunately, i don't have such a modded box.
The tuxbox project currently uses a really ugly hack to support swapping:

http://git.bocc.de/cgi-bin/gitweb.cgi?p=dbox2.git;a=commitdiff;h=fc9d6ed33d85933f3900718a118a0cc2b776f067

Thanks,
Jochen
