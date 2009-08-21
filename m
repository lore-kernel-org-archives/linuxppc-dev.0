Return-Path: <sr@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62985B7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 17:59:41 +1000 (EST)
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E571DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 17:59:38 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot@lists.denx.de
Subject: Re: [U-Boot] NAND  ECC Error with wrong SMC ording bug
Date: Fri, 21 Aug 2009 09:59:21 +0200
References: <19081.57584.173693.798535@cargo.ozlabs.ibm.com>
	<200908200701.21076.sr@denx.de> <4A8DDF72.2080808@amcc.com>
In-Reply-To: <4A8DDF72.2080808@amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908210959.21740.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	linux-mtd@lists.infradead.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Feng,

On Friday 21 August 2009 01:42:42 Feng Kan wrote:
> We had a board with high number of correctable ECC errors. Which crashed
> the jffs when it
> was miss correcting the wrong byte location.

OK, thanks.

> Do you want me to submit a patch for this, or do you prefer to do it.

Sure, please go ahead and send a patch to fix this in U-Boot as well.

Thanks.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
