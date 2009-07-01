Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 02054B70FD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:48:20 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D7F3DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:48:19 +1000 (EST)
Message-ID: <4A4BD98A.1050905@freescale.com>
Date: Wed, 01 Jul 2009 16:47:54 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
	<20090701205957.GA9583@oksana.dev.rtsoft.ru>
	<4A4BD187.8000605@freescale.com>
	<20090701212858.GA28455@oksana.dev.rtsoft.ru>
In-Reply-To: <20090701212858.GA28455@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Ira Snyder <iws@ovro.caltech.edu>,
	linuxppc-dev@ozlabs.org, Andrey Gusev <a.gusev1980@mail.ru>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> That's the main point of this patch (as subject says). 

Yes, I see that now. :-)

> You seem to be looking into an outdated kernel. ;-) IIRC, the
> first caller of kzalloc() in init_IRQ() path appeared in

Yes, you're right.

-- 
Timur Tabi
Linux kernel developer at Freescale
