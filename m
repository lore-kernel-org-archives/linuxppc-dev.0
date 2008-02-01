Return-Path: <SRS0=TP32=SW=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 2B063DDDFE
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 19:34:25 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ndfc ecc byte order
Date: Fri, 1 Feb 2008 09:34:11 +0100
References: <47A0D57C.1000104@pikatech.com> <200801302201.04552.sr@denx.de>
	<200802010912.22571.sr@denx.de>
In-Reply-To: <200802010912.22571.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802010934.12059.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 01 February 2008, Stefan Roese wrote:
> > So the SMC byte ordering is selected and it should match the version used
> > in U-Boot. In Linux the swapping is done in nand_ecc.c.
>
> Seems that I was incorrect here. Tests showed that writing from Linux and
> then reading back from U-Boot results in ECC errors. My comment above is
> bogus, since nand_calculate_ecc() from nand_ecc.c is not used with HW-ECC
> generation enabled.

And after another coffee I noticed that the current Linux implementation is 
correct. The U-Boot implementation needs to get fixed. Brown paper bag time 
for me.

Best regards,
Stefan
