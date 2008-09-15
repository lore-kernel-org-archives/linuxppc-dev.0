Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id D51BDDE3EC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Sep 2008 21:52:20 +1000 (EST)
Message-ID: <48CE4CD8.6040500@coritel.it>
Date: Mon, 15 Sep 2008 13:54:00 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: VenkataKrishna <venkatakrishnap@vrindatech.com>
Subject: Re: Modules and inserting into kernel
References: <20080915113818.35AB5DE5AF@ozlabs.org>
In-Reply-To: <20080915113818.35AB5DE5AF@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-15
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

You can build the modules with "make modules" and install them with
"make modules_install". After that, you can load your module with
modprobe or insmod command.

Regards.

VenkataKrishna ha scritto:
>  
>
> I installed ELDK kit and I compiled kernel uImage in linux. Now I want to
> build and compile device driver your target under MPC8260. How can I do this
> and inserting you module in Linux.
>
>  
>
> Thanks & Regards
>
> Venkatakrishna Pari
>
>
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
