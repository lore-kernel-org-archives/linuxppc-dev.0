Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EF7BDEA22
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 02:06:03 +1000 (EST)
Message-ID: <01e801c89e49$6d0e6400$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>, "Buildroot Mailinglist, " <buildroot@uclibc.org>
References: <014701c89bda$09380060$ad289e86@LPSC0173W>
	<fa686aa40804110655x48120e84tde01a52d8bb39a3@mail.gmail.com>
Subject: Re: zImage.embedded
Date: Mon, 14 Apr 2008 18:05:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[cross posting from one mailing list to another]

>>  is the file zImage.elf my proper network image ?
>
> What bootloader is on your board?  zImage.elf *might* be the proper
> image.  If you're using u-boot, then you want to build a uImage
> instead.

I'm trying to compile u-boot with buildroot, but it fails with:

                /usr/bin/make -j1 -C 
/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc/genepy/u-boot-1.3.2 
\
                ""_config
make[1]: Entering directory 
`/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc/genepy/u-boot-1.3.2'
make[1]: *** No rule to make target `_config'.  Stop.
make[1]: Leaving directory 
`/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc/genepy/u-boot-1.3.2'
make: *** 
[/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc/genepy/u-boot-1.3.2/.configured] 
Error 2

Apparently it expects a BOARD_NAME variable, but I don't know what to put in 
it (I looked at the makefile and can't find the ml405 referenced in there).
-- 
Guillaume Dargaud
http://www.gdargaud.net/
