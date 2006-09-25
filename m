Return-Path: <christophe.alayrac@univ-orleans.fr>
Subject: RE: ML403 patch for UBOOT
From: alayrac <christophe.alayrac@univ-orleans.fr>
To: Linuxppc-embedded@ozlabs.org
In-Reply-To: <BAY110-F21CF9E20190CB4CC022CCFB2240@phx.gbl>
References: <BAY110-F21CF9E20190CB4CC022CCFB2240@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 Sep 2006 15:02:38 +0200
Message-Id: <1159189359.4848.6.camel@Serge-Linux>
Mime-Version: 1.0
Reply-To: christophe.alayrac@univ-orleans.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Le lundi 25 septembre 2006 à 12:34 +0000, Ming Liu a écrit :
> Hi,
> Here it is...
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-August/023912.html
> 
> Regards
> Ming
> 
Thank you Ming for your prompt reply. It is exactly the pacth I've found
previously.
The pacth start with the following lines :
diff -Naur linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml300.h
linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml300.h
--- linux-2.6.17-4.patch1/arch/ppc/platforms/4xx/xilinx_ml300.h 2006-07-25 16:42:50.000000000 -0400
+++ linux-2.6.17-4.working/arch/ppc/platforms/4xx/xilinx_ml300.h        2006-08-02 19:47:00.000000000 -0400

I understand from that that it try to change linux-2.6.17-4 xilinx_ml300.h
If I type from u-boot (1.1.4) source code directory
patch -i U-BOOT 
with U-BOOT the text file containing that pacth then it stop askink for file path.

So I wonder if the pacth is for UBOOT or Linux 2.6.17-4 kernel source?

I should precise that I'm a beginner with Uboot and linux 2.6 (already port linux 2.4 on ML403 using BYU instructions)
I must miss something basic...

Thanks for your help

Chris
> 
> >From: alayrac <christophe.alayrac@univ-orleans.fr>
> >Reply-To: christophe.alayrac@univ-orleans.fr
> >To: Linuxppc-embedded@ozlabs.org
> >Subject: ML403 patch for UBOOT
> >Date: Mon, 25 Sep 2006 13:21:43 +0200
> >
> >I'm new member of this mailing list an I'm looking for some information
> >on UBOOT on ML403.
> >
> >stevea-mdi talk about a pacth from  Ameet
> >(http://www.linux2knowmore.com) but I did not succeed to find this
> >pacth.
> >The one attached to the mail
> >(http://patchwork.ozlabs.org/linuxppc/patch?id=6502)  seems to be for
> >linux 2.6.17-4 and not for UBOOT.
> >
> >Is there something I'm doing wrong?
> >
> >Where can I found a pacth for UBOOT for ML403?
> >
> >Thank you in advance for any help
> >
> >Chris
> >
> >
> >_______________________________________________
> >Linuxppc-embedded mailing list
> >Linuxppc-embedded@ozlabs.org
> >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _________________________________________________________________
> 免费下载 MSN Explorer:   http://explorer.msn.com/lccn  
> 
> 
