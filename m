Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 5B3DBDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jun 2007 22:52:27 +1000 (EST)
Message-ID: <4683AEFD.60007@anagramm.de>
Date: Thu, 28 Jun 2007 14:52:13 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
Subject: Re: General question on upgrading Linux version
References: <F795765B112E7344AF36AA911279641502D1A3FA@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A3FA@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello, Bizhan!

Bizhan Gholikhamseh (bgholikh) schrieb:
> Hi All,
> We are using MPC8541 processor from freescale. Our current kernel 
> version is based on 2.6.11 plus some patches provided by Freescale. I 
> would like to update our Kernel version to a more recent version.

I am not sure about the exact versions but you propably need to switch
over from devfs to udev. (usually no big deal)

> I would greatly appreciate if you could provide me with some general 
> guideline on how to proceed .....

I follow the latest stable and latest-git from kernel.org. I didn't run
into major problems over here for MPC8540, however I am still on the old
ARCH=ppc. ARCH=powerpc compiles fine as well. I just had no time to have
a closer look at the DeviceTree/OpenFirmware/U-Boot stuff.

Is there any brief HowTo migrate from ppc to powerpc including u-boot?

Best greets,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
