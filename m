Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0273DE109
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 06:10:53 +1000 (EST)
Message-ID: <481780BA.30101@freescale.com>
Date: Tue, 29 Apr 2008 15:10:34 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 3/6] [POWERPC] QE: prepare QE PIO code for GPIO LIB support
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190035.GC21203@polina.dev.rtsoft.ru>
In-Reply-To: <20080429190035.GC21203@polina.dev.rtsoft.ru>
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
> - split and export __par_io_config_pin() out of par_io_config_pin(), so we
>   could use the prefixed version with GPIO LIB API;
> - rename struct port_regs to qe_pio_regs, and place it into qe.h;
> - rename #define NUM_OF_PINS to QE_PIO_PINS, and place it into qe.h.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-By: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
