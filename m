Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB566DE100
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 01:09:02 +1000 (EST)
Message-ID: <48762608.3060605@freescale.com>
Date: Thu, 10 Jul 2008 10:08:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Subject: Re: linux/powerpc memory management
References: <d2b9ccd90807092114kc1883d2ud33c09c245d94d86@mail.gmail.com>
In-Reply-To: <d2b9ccd90807092114kc1883d2ud33c09c245d94d86@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

sumedh tirodkar wrote:
> Can anyone give pointers as to how memory management(detailed) is done 
> in linux on powerpc.

arch/powerpc/mm

(Hey, you wanted a detailed answer to a very broad question...)

-Scott
