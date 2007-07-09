Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F2D2DDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:08:14 +1000 (EST)
Date: Mon, 9 Jul 2007 16:08:06 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Stuart Yoder <b08248@freescale.com>
Subject: Re: [PATCH][POWERPC] document ipic level/sense info
Message-Id: <20070709160806.3b145281.kim.phillips@freescale.com>
In-Reply-To: <200707091820.l69IKjBU013685@ld0164-tx32.am.freescale.net>
References: <200707091820.l69IKjBU013685@ld0164-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 9 Jul 2007 13:20:45 -0500
Stuart Yoder <b08248@freescale.com> wrote:

> +5) Freescale IPIC Interrupt Controllers
> +---------------------------------------
> +
> +IPIC interrupt controllers are specific to Freescale 83xx
> +SOCs.  Two cells are required to encode interrupt information.
> +The first cell defines the interrupt number.  The second cell
> +defines the sense and level information.
> +
> +Sense and level information follows the Linux convention
> +(specified in include/linux/interrupt.h) and should be encoded
> +as follows:
> +
> +	1 =  low to high edge sensitive type enabled

the IPIC doesn't support this sense type.

> +	2 =  high to low edge sensitive type enabled
> +	4 =  active high level sensitive type enabled

nor this.

i.e, sense types 1 and 4 should not be documented in an IPIC context.

Kim
