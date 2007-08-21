Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id A91DDDDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 08:14:26 +1000 (EST)
Message-ID: <46CB63BE.2050700@anagramm.de>
Date: Wed, 22 Aug 2007 00:14:22 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Robert Woodworth <rwoodworth@securics.com>
Subject: Re: Xilinx Virtex4 FX PPC
References: <1187625654.6336.28.camel@PisteOff>	<20070820113549.7cc3ac45@weaponx.rchland.ibm.com>
	<1187630817.6336.34.camel@PisteOff>
In-Reply-To: <1187630817.6336.34.camel@PisteOff>
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

Hi, Robert, Josh

>>> Question 1:
>>> Do I need a special glibc for the Xilinx PPC 405????  
>>> Does a normal PPC glibc have more "advanced" instructions compiled in
>>> that will not work on a Xilinx PPC 405??

Have a look at the eglibc project (embedded glibc) at http://www.eglibc.org
I think they support all kind of soft-fp configurations.
(i.e. The stuff seems to work fine on my MPC8540 e500 core with soft-fp)

>> Make sure you're building glibc with soft-fp, or make sure you have
>> CONFIG_MATH_EMULATION enabled in your kernel.  The PPC 405 doesn't have
>> an FPU.
>>
>> josh
> 
> CONFIG_MATH_EMULATION fixed it!!
> 
> What are the opinions out there? 
> Kernel fp or glibc soft-fp??

AFAICT: soft-fp in (e)glibc. They should be faster / hopefully more
optimized to your specific cpu.

Regards,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
