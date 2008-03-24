Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 628A7DDEDF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 09:05:00 +1100 (EST)
Message-ID: <47E82591.9050907@freescale.com>
Date: Mon, 24 Mar 2008 17:05:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: James Black <jblack547@gmail.com>
Subject: Re: muram in device tree for mpc8250 in arch/powerpc
References: <b77025b40803191006m60dc3145la368ac227df43b17@mail.gmail.com>	
	<47E2AADD.6090101@freescale.com>	
	<b77025b40803201602q68fce3e1j703502a270351179@mail.gmail.com>	
	<20080321161833.GA4170@loki.buserror.net>	
	<b77025b40803211314g74a41aa9of01f7cf3560a2505@mail.gmail.com>	
	<47E41BE7.9020109@freescale.com>	
	<b77025b40803211435g25e8cee7w75bfe4ed9c13796@mail.gmail.com>	
	<47E7DC46.2010806@freescale.com>	
	<b77025b40803241445w46aaf071k427df888b4597c4d@mail.gmail.com>	
	<47E822EC.9030408@freescale.com>
	<b77025b40803241459s4537b1f6rdcf85c59a4af6707@mail.gmail.com>
In-Reply-To: <b77025b40803241459s4537b1f6rdcf85c59a4af6707@mail.gmail.com>
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
> OK, you are right. I was looking at my old copy I was trying to fix.
> The error is,
> 
> arch/powerpc/boot/cuboot-pq2.c: In function 'fixup_pci':
> arch/powerpc/boot/cuboot-pq2.c:204: warning: implicit declaration of
> function '__ilog2_u32'

It's defined as an inline function in ops.h.  Do you have an old ops.h?

-Scott
