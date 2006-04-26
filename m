Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE8C7679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Apr 2006 04:54:19 +1000 (EST)
Received: from CA1EXBH01.adcorp.kla-tencor.com
	(ca1exbh01.adcorp.kla-tencor.com [10.60.33.3])
	by ca1mail04.kla-tencor.com (8.12.10/8.12.11) with ESMTP id
	k3QIsFwK025133
	for <linuxppc-embedded@ozlabs.org>; Wed, 26 Apr 2006 11:54:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How do you make linux 2.6.10 U-Boot aware?
Date: Wed, 26 Apr 2006 11:54:13 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE027DEF15@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm using MontaVista linux 4.01 for the PPC440GX which is based on
2.6.10.  It doesn't read the bootargs from U-Boot however.  Does anyone
out there have a synopsis of what needs to be modified (bd_info, etc.)
to make this work with a 2.6.10 based release?

Thanks,

Marc W. Howard
