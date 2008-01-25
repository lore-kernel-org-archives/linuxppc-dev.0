Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F233BDDE03
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 21:27:49 +1100 (EST)
Message-ID: <4799B985.70605@scram.de>
Date: Fri, 25 Jan 2008 11:27:17 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv3 6/7] [POWERPC] Rename commproc to cpm1 and cpm2_common.c
	to cpm2.c
References: <4798AC8B.9090400@scram.de>
	<F4B3DC7D-AC57-4C37-8708-5A3E73F5F97C@kernel.crashing.org>
In-Reply-To: <F4B3DC7D-AC57-4C37-8708-5A3E73F5F97C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

>> drivers/net/fec.c                             |    8 --------
>> drivers/net/fec.h                             |    2 +-
> 
> asm-m68knommu/commproc.h ?? these are only built on coldfire.

Yes. Here I just removed dead code (commented out using #ifdef on coldfire). Apparently the driver was
used on MPC8xx before or was copied from there but never cleaned up? Maybe this should be a seperate patch?

>> drivers/serial/68360serial.c                  |    2 +-
> 
> I think this is using asm-m68knommu/commproc.h

Oops, that one slipped through :-/.

Thanks,
Jochen
