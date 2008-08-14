Return-Path: <jewirth@googlemail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id A0A21DE206
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 23:54:42 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so358480ugf.0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 06:54:39 -0700 (PDT)
Message-ID: <f944af2a0808140654q2468e6a7m1424b90767ea765e@mail.gmail.com>
Date: Thu, 14 Aug 2008 15:54:38 +0200
From: "Jens Wirth" <jewirth@googlemail.com>
To: linuxppc-embedded@ozlabs.org, wangyanlong <killyouatonce@gmail.com>
Subject: Re: How to use ramdisk on the ml300?
In-Reply-To: <18979320.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <931ae8260808132008i1cac2e91kc76c099ecc574cd0@mail.gmail.com>
	<f944af2a0808140004w70948283nde0978d34d1db261@mail.gmail.com>
	<18979320.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

On Thu, Aug 14, 2008 at 12:44 PM, wangyanlong <killyouatonce@gmail.com> wrote:
>
> Hi JensWirth,
>    Thanks  for your reply :). I have some questions here.
>    (1)You told me "make simpleImage.virtex405-ml300",i only know "make
> zImage" and "make zImage.initrd" ,what it is this command mean???

It's a relatively new target in the arch/powerpc/boot/Makefile which
wraps your compressed kernel and bootcode together with a device tree
blob. A device tree blob is created using a device tree source (dts).

>    (2)What is dts ? I don't know what is this :(

A device tree source is plain text. Look inside arch/powerpc/boot/dts.
A device tree is essential if you want to boot an ARCH=powerpc
Linux-Kernel. Read this:
http://ols.fedoraproject.org/OLS/Reprints-2008/likely2-reprint.pdf

I supposed you were using 2.6.26 or 2.6.27-rcX

Regards
Jens
