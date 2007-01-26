Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7668DE099
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 18:41:08 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890087479@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890087479@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <315BEE09-4826-47F5-9E85-D268A4EA3022@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 8360 UCC_GETH INIT_WORK compile error
Date: Fri, 26 Jan 2007 01:40:12 -0600
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: Russell McGuire <rmcguire@uwbt.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 26, 2007, at 12:18 AM, Li Yang-r58472 wrote:

> Russ,
>
> Please use the latest git tree.  The fix has been merged.
>
> - Leo
>
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org =20
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] =20=

> On Behalf Of Russell McGuire
> Sent: Friday, January 26, 2007 2:07 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: 8360 UCC_GETH INIT_WORK compile error
>
> Kumar / ALL,
>
> I was having problems compiling the UCC_GETH driver for 8360.
>
> INIT_WORK declared with 2 parameters instead of 3.
>
> Googling around, I noticed that somebody posted a temporary patch =20
> back in December 14, 2006.
>
> Has this been resolved?
>
> I am not able to boot the 2.6.19.2 Kernel the moment since the =20
> Ethernet/UCCF driver won=92t compile.

As Leo said, 2.6.20-rc6 has the fixes from myself/Timur that address =20
this:
http://master.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/=20
linux-2.6.git;a=3Dcommit;h=3Ddf19b6b020791b4c42e7cf2e4f582454cbc49251
http://master.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/=20
linux-2.6.git;a=3Dcommit;h=3D6bf446522b246194551cf167f0168792080d6118

(not sure if you need the second or not on 2.6.19).

- k=
