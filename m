Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48E08DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 03:33:42 +1000 (EST)
Date: Fri, 21 Sep 2007 12:33:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 08/10] bootwrapper: Add a firmware-independent "raw"
	target.
Message-ID: <20070921173333.GC23602@ld0162-tx32.am.freescale.net>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192116.GH32113@ld0162-tx32.am.freescale.net>
	<fa686aa40709211031t687310fdk9ca703ea8cf759e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40709211031t687310fdk9ca703ea8cf759e7@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 11:31:11AM -0600, Grant Likely wrote:
> Are these makefile changes complete?  When I attempt to compile with
> this patch I get the following error:
> 
> grant@trillian:~/hacking/linux-2.6$ ppc4xx make
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/linux/compile.h
> make[1]: *** No rule to make target `arch/powerpc/boot/zImage.raw',
> needed by `arch/powerpc/boot/zImage'.  Stop.
> make: *** [zImage] Error 2
> grant@trillian:~/hacking/linux-2.6$

Odd... It should match the zImage.% target.

-Scott
