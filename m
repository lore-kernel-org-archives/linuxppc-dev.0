Return-Path: <SRS0=XYxR=QI=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: about uImage-DENX-v2.6.14 config
Date: Thu, 15 Nov 2007 07:13:27 +0100
References: <4b7912400711140706i3c96456bua42dc01c6cb5467b@mail.gmail.com>
In-Reply-To: <4b7912400711140706i3c96456bua42dc01c6cb5467b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711150713.28211.sr@denx.de>
Cc: info@denx.de, zhangwei zhang <linda.zhangwei@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 14 November 2007, zhangwei zhang wrote:
> Hello, I have a problem when using linux-2.6.14(download from
> ftp.denx.de) for RTAI on ppc440EP.

RTAI on PPC? I thought RTAI was dead for anything other than X86.

And 2.6.14 is quite old. I suggest you use a newer binary version or compile a 
the image from the current kernel source.

> I use the ELDK4.1 and when boot the 
> uImage I compiled , I always have the problem as following:
>
> ## Booting image at 00500000 ...
>    Image Name:   Linux-2.6.14
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1155686 Bytes =  1.1 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>
> then it stopped . I am afraid that maybe the problem comes from the
> config. I have ever use the uImage-DENX-v2.6.14 you offered in
> ftp.denx.de/pub/linux/amcc/image/yosemite/ and it works. So can you
> send me a config file for 2.6.14 to me? Thank you.

Please don't stick with 2.6.14. Download the current kernel:

http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git;a=summary

and there you will find the .config for the Yosemite 
(arch/ppc/configs/yosemite_defconfig).

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
