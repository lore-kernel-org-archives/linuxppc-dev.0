Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7EDEDECFE
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:08:37 +1000 (EST)
Message-Id: <2AD4B8C7-D6BF-44C2-B1DF-883EC16CFD71@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080523163856.GB16137@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 2/7] [POWERPC] QE: add support for QE USB clocks routing
Date: Tue, 10 Jun 2008 11:08:29 -0500
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163856.GB16137@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 11:38 AM, Anton Vorontsov wrote:

> This patch adds a function to the qe_lib to setup QE USB clocks  
> routing.
> To setup clocks safely, cmxgcr register needs locking, so I just  
> reused
> ucc_lock since it was used only to protect cmxgcr.
>
> The idea behind placing clocks routing functions into the qe_lib is  
> that
> later we'll hopefully switch to the generic Linux Clock API, thus, for
> example, FHCI driver may be used for QE and CPM chips without nasty  
> #ifdefs.
>
> This patch also fixes QE_USB_RESTART_TX command definition in the  
> qe.h.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-By: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/qe_lib/Kconfig  |    4 ++
> arch/powerpc/sysdev/qe_lib/Makefile |    1 +
> arch/powerpc/sysdev/qe_lib/ucc.c    |    7 ++--
> arch/powerpc/sysdev/qe_lib/usb.c    |   55 ++++++++++++++++++++++++++ 
> +++++++++
> include/asm-powerpc/qe.h            |   23 ++++++++++++++-
> 5 files changed, 86 insertions(+), 4 deletions(-)
> create mode 100644 arch/powerpc/sysdev/qe_lib/usb.c


applied.

- k
