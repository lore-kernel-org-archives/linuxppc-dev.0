Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA6BBDDE0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 06:34:12 +1100 (EST)
Message-ID: <4738909C.6030407@freescale.com>
Date: Mon, 12 Nov 2007 11:42:52 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] powerpc: Add support for PORTA sor and PORTB odr registers
References: <473736FB.7090609@scram.de>
In-Reply-To: <473736FB.7090609@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
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
> PORTA has an so register and PORTB had an odr register, as well.
> However, the PORTB odr register is only 16bit.

Which 8xx chip has a so register on port A?  I checked the 860, 866, 
885, and 823 manuals and didn't see one.

-Scott
