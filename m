Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9341DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Nov 2007 10:48:12 +1100 (EST)
Message-ID: <47437241.7040303@freescale.com>
Date: Tue, 20 Nov 2007 17:48:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH try2] powerpc: Add support for PORTA and PORTB odr
	registers
References: <474316A4.4010807@scram.de>
In-Reply-To: <474316A4.4010807@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> PORTA and PORTB have odr registers, as well. However, the PORTB odr
> register is only 16bit.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

Acked-by: Scott Wood <scottwood@freescale.com>

BTW, you may want to send the patches to linuxppc-dev rather than 
linuxppc-embedded...  Despite what MAINTAINERS says, the former is where 
most patches get posted.

-Scott
