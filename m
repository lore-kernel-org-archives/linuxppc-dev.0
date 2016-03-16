Return-Path: <intermediadc@hotmail.com>
Received: from DUB004-OMC3S18.hotmail.com (dub004-omc3s18.hotmail.com
 [157.55.2.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ1gQ22j4zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 17:25:05 +1100 (AEDT)
Message-ID: <DUB406-EAS2759FE0784777D029FB586BC88A0@phx.gbl>
Content-Type: text/plain; charset="us-ascii"
Subject: Re: Freescale P5020 cpu will be kvm-pr?
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
 <1457482205.5360.114.camel@buserror.net>
 <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
 <DUB117-W6931726DAC4EB1D528591DC8B40@phx.gbl>
 <1458081467.12370.31.camel@buserror.net>
From: luigi burdo <intermediadc@hotmail.com>
MIME-Version: 1.0 (1.0)
In-Reply-To: <1458081467.12370.31.camel@buserror.net>
Date: Wed, 16 Mar 2016 07:24:59 +0100
To: Scott Wood <oss@buserror.net>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi Scott,
the P5020 mmu is signed by the kernel no book3e found=20
kvm ppc64 crash if run by qemu.
in the kernel( 4.5 too)all is enabled we had a base .config by freescale/nix=
=20
where kvm options and book3e  where enabled.
my suspect is this can be an generated issue by  the host uboot or a missed t=
db parameter and not a linux kernel problem.
Just was need an expert point of view .
thanks for your time
luigi burdo

Inviato da iPad

> Il giorno 15 mar 2016, alle ore 23:37, Scott Wood <oss@buserror.net> ha sc=
ritto:
>=20
>> On Thu, 2016-03-10 at 11:22 +0100, luigi burdo wrote:
>> Hi Scott,
>> sorry for late reply in this last few days  i become another time father .=

>> In any way for better explain the issue i attached my dmesg log
>> probably will make understand better than my poor english
>>=20
>> Thanks for your time
>> Luigi Burdo
>> AmigaOne X5000 beta tester
>=20
> Please don't top-post.
>=20
> Is there anything particular about that log that you are concerned about?
>=20
> -Scott
>=20
>=20
