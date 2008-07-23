Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 80C35DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 16:56:04 +1000 (EST)
Message-ID: <4886D685.5050902@coritel.it>
Date: Wed, 23 Jul 2008 08:58:13 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Naresh Bhat <nareshgbhat@gmail.com>
Subject: Re: Kernel is Hanging for page size 16KB.
References: <cf9b3c760807222342h47ff8d0atd74fd5a583a62d9c@mail.gmail.com>
In-Reply-To: <cf9b3c760807222342h47ff8d0atd74fd5a583a62d9c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Naresh Bhat ha scritto:
> Hi Guys,
> 
> I have a board MIPS Malta and Linux 2.6.10 is running on that. By default
> 4KB page size will be allocated in the kernel (I mean to say I saw it when I
> do the "make menuconfig".
> 
> Problem is:
> 
> When I changed the page size to 16KB it will hang after mounting the file
> system. I am using the NFS for booting the board.
> 
> 
> Can anybody help me on this issue...
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

This is not a MIPS a mailing list.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
