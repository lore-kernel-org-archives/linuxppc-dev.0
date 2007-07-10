Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A2DEDDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 22:59:54 +1000 (EST)
In-Reply-To: <200707091820.l69IKjBU013685@ld0164-tx32.am.freescale.net>
References: <200707091820.l69IKjBU013685@ld0164-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C9E91A52-D192-4EBE-A925-7E244DEB6166@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] document ipic level/sense info
Date: Tue, 10 Jul 2007 14:59:36 +0200
To: Stuart Yoder <b08248@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +Sense and level information follows the Linux convention
> +(specified in include/linux/interrupt.h) and should be encoded
> +as follows:
> +
> +	1 =  low to high edge sensitive type enabled
> +	2 =  high to low edge sensitive type enabled
> +	4 =  active high level sensitive type enabled
> +	8 =  active low level sensitive type enabled

Please note that using the same bit encoding as some Linux
version does buys you (almost) nothing; a good parser for
this OF node should do range/value checking on this property
anyway, translating the values in the process costs nothing.


Segher
