Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7CCA3DE72D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:11:24 +1000 (EST)
Message-Id: <D72D459E-8CCE-4C72-82BB-9F2961C5BE63@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080411170340.GA2649@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/8] [POWERPC] fsl_lbc: implement few routines to manage
	FSL UPMs
Date: Mon, 14 Apr 2008 10:11:16 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172408.GB7727@localhost.localdomain>
	<EE642BFC-4262-44E8-BD48-E76E5418C276@kernel.crashing.org>
	<20080411161311.GA28067@polina.dev.rtsoft.ru>
	<47FF8F56.50803@freescale.com>
	<20080411170340.GA2649@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
>
> Subject: [POWERPC] fsl_lbc: implement few UPM routines
>
> Freescale UPM can be used to adjust localbus timings or to generate
> orbitrary, pre-programmed "patterns" on the external Localbus signals.
> This patch implements few routines so drivers could work with UPMs in
> safe and generic manner.
>
> So far there is just one user of these routines: Freescale UPM NAND
> driver.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/Kconfig          |    5 ++
> arch/powerpc/sysdev/Makefile  |    1 +
> arch/powerpc/sysdev/fsl_lbc.c |  129 ++++++++++++++++++++++++++++++++ 
> +++++++++
> include/asm-powerpc/fsl_lbc.h |   88 ++++++++++++++++++++++++++++
> 4 files changed, 223 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_lbc.c

applied.

- k
