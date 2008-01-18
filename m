Return-Path: <r_wehbi@yahoo.fr>
Received: from web26706.mail.ukl.yahoo.com (web26706.mail.ukl.yahoo.com
	[217.146.176.69]) by ozlabs.org (Postfix) with SMTP id EB5F3DDEE6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 01:47:37 +1100 (EST)
Date: Fri, 18 Jan 2008 15:47:35 +0100 (CET)
From: WEHBI Rami <r_wehbi@yahoo.fr>
Subject: RE : Re: array type has incomplete element type
To: Joachim Meyer <Jogi95@web.de>
In-Reply-To: <541911165@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <556588.57515.qm@web26706.mail.ukl.yahoo.com>
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

Hi all!

I've just download the linux kernel from this site
(provided by Joachim Meyer):
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

using the command :   cg clone 
git://git.secretlab.ca/git/linux-2.6-virtex.git

I am using the crosstool compiler :
gcc-4.1.1-glibc-2.3.6

I am using Debian linux destribution.

Here is the begining of my problems :

first I got the binutils version error (so I corrected
the /arch/ppc/Makefile to accept the current version).
now it is OK.

right now my problem is :
make ARCH=ppc CROSS_COMPILE=powerpc-405-linux-gnu-
bzImage
/bin/sh: -c: line 1: syntax error: unexpected end of
file
make: *** [checkbin] Erreur 2

any help is much appreciated,

Best regards,

Rami






--- Joachim Meyer <Jogi95@web.de> a écrit :

> Hi
> 
> I managed to set up linux for the ml310 (Virtex 2
> pro) these days.
> I don't know how similar it is, but here is what
> worked for me:
> I used the kernel (newest 2.6.24-rc3) from the
> secret lab tree:
>
------------------------------------------------------------------
>
http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex
> --> look at vendow trees.
>
-------------------------------------------------------------------
> 
> I also used crosstool but with
> gcc-3.4.5-glibc-2.3.6
> maybe you give it a try
> 
> good Luck
> Joachim
>
_______________________________________________________________________
> Jetzt neu! Schützen Sie Ihren PC mit McAfee und
> WEB.DE. 30 Tage
> kostenlos testen.
>
http://www.pc-sicherheit.web.de/startseite/?mc=022220
> 
> 



      _____________________________________________________________________________ 
Ne gardez plus qu'une seule adresse mail ! Copiez vos mails vers Yahoo! Mail http://mail.yahoo.fr
