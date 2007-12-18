Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 357AADDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Dec 2007 10:59:27 +1100 (EST)
Message-ID: <47685ED8.2060204@freescale.com>
Date: Tue, 18 Dec 2007 17:59:20 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: DTS files,  83xx, clock frequencies
References: <mailman.543.1198006353.17691.linuxppc-embedded@ozlabs.org>
	<000001c841ce$d11fcdd0$6405a8c0@absolut>
In-Reply-To: <000001c841ce$d11fcdd0$6405a8c0@absolut>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Russell McGuire wrote:
> I note that in most of the 83xx dts config files that the different
> frequency fields are being populated with non-zero numbers. i.e. bus-freq,
> clock-freq, core-freq, etc...
> 
> Isn't default behavior that these fields are kept from the <BIOS> U-boot
> during boot, if a zero is present?

U-boot overwrites those values regardless of whether they were zero in 
the dts.

> Is there any advantage to resetting them
> within the dts file during linux boot up?

No, and it doesn't.  If you're looking arch/powerpc/boot, then that's 
for compatibility with non-device-tree-aware u-boots.

-Scott
