Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 268ADDDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 May 2007 22:54:07 +1000 (EST)
Message-ID: <4656DC7C.8020503@anagramm.de>
Date: Fri, 25 May 2007 14:54:20 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Sasvata Chatterjee <sasvata.chatterjee@gmail.com>
Subject: Re: Latest GCC/GLIBC working combo for a Linux 2.4.x kernel?
References: <a9fc2a630705241728q4d203569n6eb008cc65a7eba9@mail.gmail.com>
In-Reply-To: <a9fc2a630705241728q4d203569n6eb008cc65a7eba9@mail.gmail.com>
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

Hi, Sasvata!

> We are using a RHEL/386 machine to cross-compile for Debian/PowerPC 
> (8260) target, a few year old embedded system that we inherited.  The 
> kernel is 2.4.9. Using crosstools, and following Dan Kegel's notes, the 
> combo we have is gcc-2.95-3/glibc-2.2.5.
> 
> Does anybody have any working version using newer versions of the 2.4 
> kernel and newer GCC versions for a powerpc-603e target?  One motivation 
> is to use BusyBox-1.5.1, but I am told on that list that GCC 2/x is too 
> old (I tried before I asked, it doesn't compile).

It's propably painful to work your way through crosstools with such an
old toolchain. I would have a look if one of the ELDK's from
http://www.denx.de can be used for your board - at least for a good start.
If you run into problems with older linux-2.4 kernel version with the newer ELDK's,
you can also go back to some older version?

> Any help, pointers, example config files for crosstools, etc. would be 
> really appreciated!

You are always welcome at their mailing list. See:
http://kegel.com/crosstool

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
