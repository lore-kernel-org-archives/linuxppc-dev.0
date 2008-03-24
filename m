Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BDF5DDFD8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 08:53:44 +1100 (EST)
Message-ID: <47E822EC.9030408@freescale.com>
Date: Mon, 24 Mar 2008 16:53:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: James Black <jblack547@gmail.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>	
	<b77025b40803191107x2f9a7884n9b7f062fcf45370@mail.gmail.com>	
	<b77025b40803201102w200dde6fuc4235d9a3cb8b0dd@mail.gmail.com>	
	<47E2AADD.6090101@freescale.com>	
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>	
	<20080321161833.GA4170@loki.buserror.net>	
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>	
	<47E41BE7.9020109@freescale.com>	
	<b77025b40803211435g25e8cee7w75bfe4ed9c13796@mail.gmail.com>	
	<47E7DC46.2010806@freescale.com>
	<b77025b40803241445w46aaf071k427df888b4597c4d@mail.gmail.com>
In-Reply-To: <b77025b40803241445w46aaf071k427df888b4597c4d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

James Black wrote:
> I started from scratch and am trying to build the cuImage. I get this
> compiler error.
> 
> arch/powerpc/boot/cuboot-pq2.c:14:20: error: bitops.h: No such file or directory
> arch/powerpc/boot/cuboot-pq2.c: In function 'fixup_pci':
> arch/powerpc/boot/cuboot-pq2.c:205: warning: implicit declaration of
> function '__ilog2_u32'
> 
> I looks as though cuboot-pq2.c expects bitops.h to be in the same
> directory, but it has moved to
> linux/include/asm-powerpc/bitops.h

I don't see any reference to bitops.h in cuboot-pq2.c...
Line 14 includes "ops.h".

-Scott
