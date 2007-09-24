Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C085ADDE02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 05:30:07 +1000 (EST)
Message-ID: <46F8101E.1050000@freescale.com>
Date: Mon, 24 Sep 2007 14:29:34 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
References: <46F6C9DC.90008@scram.de> <46F7DE85.7000401@freescale.com>
	<46F7EE95.1040509@scram.de> <46F80049.2030509@freescale.com>
	<FF1A2486-BE77-49F8-99F3-B09B4EEAF50D@embeddedalley.com>
In-Reply-To: <FF1A2486-BE77-49F8-99F3-B09B4EEAF50D@embeddedalley.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Sep 24, 2007, at 11:22 AM, Scott Wood wrote:
> 
>> cpmp is a physical address on arch/ppc?
> 
> No, it's a well known ioremaped() address into the IMMR space.

Maybe that's how it was, but the current code initializes it (more or
less) directly with IMAP_ADDR, which also gets fed into ioremap.

One of the two has got to be wrong.

-Scott
