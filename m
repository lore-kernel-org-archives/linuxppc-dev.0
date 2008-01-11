Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75FE4DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jan 2008 04:27:57 +1100 (EST)
Message-ID: <4787A71E.7000509@freescale.com>
Date: Fri, 11 Jan 2008 11:27:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: raul.moreno@telvent.abengoa.com
Subject: Re: 2.6.22-ppc8xx fec.c bugs
References: <OF431AD1B5.8B0529FD-ONC12573CD.002EB1C5-C12573CD.0030B37E@abengoa.com>
In-Reply-To: <OF431AD1B5.8B0529FD-ONC12573CD.002EB1C5-C12573CD.0030B37E@abengoa.com>
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

raul.moreno@telvent.abengoa.com wrote:
> I didn't know ppc was deprecated. Why is it so? 

Having separate 32 and 64 bit powerpc trees was a maintenance headache. 
  The way arch/ppc is structured was a maintenance headache.

> I have been using this architecture since I started with Linux (not too
> long ago) because I manage a mpc866 processor.

mpc866 chips are supported in arch/powerpc.

> Do you mean that I should port to arch/powerpc?

Yes.

-Scott
