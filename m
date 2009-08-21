Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 613B5B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 04:55:13 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 6BADEDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 04:55:09 +1000 (EST)
Date: Fri, 21 Aug 2009 14:55:06 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/1] Fix ECC Correction bug for SMC ordering for NDFC
	driver.
Message-ID: <20090821145506.53275701@lappy.seanm.ca>
In-Reply-To: <1250813957-1786-1-git-send-email-fkan@amcc.com>
References: <1250813957-1786-1-git-send-email-fkan@amcc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 20 Aug 2009 17:19:17 -0700
Feng Kan <fkan@amcc.com> wrote:

> Fix ECC Correction bug where the byte offset location were double
> fliped causing correction routine to toggle the wrong byte location
> in the ECC segment. The ndfc_calculate_ecc routine change the order
> of getting the ECC code.

It looks like another fix for this bug is to leave the current code
alone and turn off CONFIG_MTD_NAND_ECC_SMC.

This could be a better fix if this is the way u-boot currently works.
Has anybody verified if the current u-boot has the ECC problem?

Cheers,
   Sean
