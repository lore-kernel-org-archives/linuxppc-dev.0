Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2DF62B7BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:26:27 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D4F6CDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 16:26:23 +1000 (EST)
Date: Fri, 21 Aug 2009 02:26:19 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: vimal singh <vimal.newwork@gmail.com>
Subject: Re: [U-Boot] NAND ECC Error with wrong SMC ording bug
Message-ID: <20090821022619.482158bb@lappy.seanm.ca>
In-Reply-To: <ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<4A8C87E6.6070702@amcc.com>
	<20090820003851.1a532444@lappy.seanm.ca>
	<200908200701.21076.sr@denx.de>
	<20090820153644.631dbd7b@lappy.seanm.ca>
	<ce9ab5790908202217t2430646co5059f308a23d7397@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>, Feng Kan <fkan@amcc.com>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 21 Aug 2009 10:47:09 +0530
vimal singh <vimal.newwork@gmail.com> wrote:

> Just one question: did you enabled MTD_NAND_ECC_SMC in configs?

It is automagically selected when you select the NDFC driver.

Cheers,
   Sean
