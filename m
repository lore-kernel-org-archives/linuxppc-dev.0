Return-Path: <timur@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6ACD8B70FF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 07:48:49 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC30BDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 07:48:48 +1000 (EST)
Message-ID: <4A4BD9BC.5030200@freescale.com>
Date: Wed, 01 Jul 2009 16:48:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: Don't use alloc_bootmem() in init_IRQ() path
References: <20090701230831.3828e0bf@power-debian>
	<20090701194819.GB20522@ovro.caltech.edu>
	<20090701205957.GA9583@oksana.dev.rtsoft.ru>
In-Reply-To: <20090701205957.GA9583@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> This patch fixes various badnesses like this for all interrupt
> controllers:

...
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>


-- 
Timur Tabi
Linux kernel developer at Freescale
