Return-Path: <fabien.fb@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 97DD6DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 23:40:01 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so3289951nfd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 04:40:00 -0800 (PST)
Message-ID: <f8f856500711230439q39c352ffi4cf3a206de68733a@mail.gmail.com>
Date: Fri, 23 Nov 2007 13:39:59 +0100
From: fabien <fabien.fb@gmail.com>
To: "Clemens Koller" <clemens.koller@anagramm.de>
Subject: Re: cant' compile busybox-1.8.1 with eldk 4.1
In-Reply-To: <4746C1F6.9050601@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <f8f856500711230256j5f3c7b9fneb7351a4fdfdfe09@mail.gmail.com>
	<4746C1F6.9050601@anagramm.de>
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

Thanks Clemens i've opened a thread in busybox mailing list :
http://www.busybox.net/lists/busybox/2007-November/029322.html

2007/11/23, Clemens Koller <clemens.koller@anagramm.de>:
> fabien schrieb:
>  > I try to compile busybox for my ppc custom board.
>
> What ARCH/cpu?
>
>  > I successfuly
>  > compile kernel 2.6.19 with
>  > eldk and boot it. Now i try to get busybox working but i get some
>  > errors at compile time.
>  > It's look strange if someone can spend one minute to look at the compi=
le log
>  > What step could i miss ?
>
>  > [...]
>  > /opt/eldk/usr/../ppc_8xx/usr/include/linux/param.h:4:23: error:
>  > asm/param.h: No such file or directory
>  > make[1]: *** [applets/applets.o] Erreur 1
>  > make: *** [applets] Erreur 2
>
> It looks like your kernel headers (ARCH-specific or generic)
> are broken or missing.
> See i.e. Linux From Scratch to get an idea about the dependencies.
> Or, see latest kernel's 'make headers_install' target and how it is used.
> Google is your friend, here...
>
> The busybox mailing list would be more suited for this question.
>
> Regards,
>
> Clemens Koller
> __________________________________
> R&D Imaging Devices
> Anagramm GmbH
> Rupert-Mayer-Stra=DFe 45/1
> Linhof Werksgel=E4nde
> D-81379 M=FCnchen
> Tel.089-741518-50
> Fax 089-741518-19
> http://www.anagramm-technology.com
>
>
