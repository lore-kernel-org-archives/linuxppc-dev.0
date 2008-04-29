Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA86ADEA71
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 05:57:45 +1000 (EST)
Message-ID: <48177DAE.7030807@freescale.com>
Date: Tue, 29 Apr 2008 14:57:34 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/6] [POWERPC] QE: add support for QE USB clocks routing
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190031.GB21203@polina.dev.rtsoft.ru>
In-Reply-To: <20080429190031.GB21203@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> This patch adds a function to the qe_lib to setup QE USB clocks routing.
> To setup clocks safely, cmxgcr register needs locking, so I just reused
> ucc_lock since it was used only to protect cmxgcr.
> 
> The idea behind placing clocks routing functions into the qe_lib is that
> later we'll hopefully switch to the generic Linux Clock API, thus, for
> example, FHCI driver may be used for QE and CPM chips without nasty #ifdefs.
> 
> This patch also fixes QE_USB_RESTART_TX command definition in the qe.h.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-By: Timur Tabi <timur@freescale.com>

Anton, please be sure to CC: me on any QE library patches you send out.

-- 
Timur Tabi
Linux kernel developer at Freescale
