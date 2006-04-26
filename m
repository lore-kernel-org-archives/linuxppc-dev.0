Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2985A679EF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 05:02:44 +1000 (EST)
Date: Wed, 26 Apr 2006 12:02:41 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Subject: Re: How do you make linux 2.6.10 U-Boot aware?
Message-ID: <20060426190241.GA20725@gate.ebshome.net>
References: <91B22F93A880FA48879475E134D6F0BE027DEF15@CA1EXCLV02.adcorp.kla-tencor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE027DEF15@CA1EXCLV02.adcorp.kla-tencor.com>
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

On Wed, Apr 26, 2006 at 11:54:13AM -0700, Howard, Marc wrote:
> Hi,
> 
> I'm using MontaVista linux 4.01 for the PPC440GX which is based on
> 2.6.10.  It doesn't read the bootargs from U-Boot however.  Does anyone
> out there have a synopsis of what needs to be modified (bd_info, etc.)
> to make this work with a 2.6.10 based release?

Please, take a look at Ocotea port in the latest 2.6 kernel. It 
supports booting from PIBS and U-Boot.

-- 
