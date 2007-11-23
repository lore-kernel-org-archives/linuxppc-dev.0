Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 1C4FBDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 23:05:17 +1100 (EST)
Message-ID: <4746C1F6.9050601@anagramm.de>
Date: Fri, 23 Nov 2007 13:05:10 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: fabien <fabien.fb@gmail.com>
Subject: Re: cant' compile busybox-1.8.1 with eldk 4.1
References: <f8f856500711230256j5f3c7b9fneb7351a4fdfdfe09@mail.gmail.com>
In-Reply-To: <f8f856500711230256j5f3c7b9fneb7351a4fdfdfe09@mail.gmail.com>
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

fabien schrieb:
 > I try to compile busybox for my ppc custom board.

What ARCH/cpu?

 > I successfuly
 > compile kernel 2.6.19 with
 > eldk and boot it. Now i try to get busybox working but i get some
 > errors at compile time.
 > It's look strange if someone can spend one minute to look at the compile log
 > What step could i miss ?

 > [...]
 > /opt/eldk/usr/../ppc_8xx/usr/include/linux/param.h:4:23: error:
 > asm/param.h: No such file or directory
 > make[1]: *** [applets/applets.o] Erreur 1
 > make: *** [applets] Erreur 2

It looks like your kernel headers (ARCH-specific or generic)
are broken or missing.
See i.e. Linux From Scratch to get an idea about the dependencies.
Or, see latest kernel's 'make headers_install' target and how it is used.
Google is your friend, here...

The busybox mailing list would be more suited for this question.

Regards,

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
