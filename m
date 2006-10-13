Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 1E29D67C27
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 01:39:38 +1000 (EST)
Subject: RE: GCC version to kernel version
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 13 Oct 2006 11:39:37 -0400
Message-ID: <3C02138692C13C4BB675FE7EA24095291F5A15@bluefin.Soneticom.local>
In-reply-to: <EE6BAB8C-DD74-412B-BDD1-1758426B62F7@kernel.crashing.org>
From: "Clint Thomas" <cthomas@Soneticom.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I tried building some different cross-tools earlier on today that used
GCC 3.4.3 and GLIBC 2.3.3 (I believe Kumar, you provided links to these
in another mailing list) They were from some e500 patches to
crosstool-0.28, but I decided to just patch crosstool-0.42 since that is
what is available. They were not able to compile my linux kernel source
without a build error, so I am running out of ideas. I have been trying
to build GCC 3.4.1 / GLIBC 2.3.3 by passing it the necessary
TARGET_CFLAGS=3D"-msoft-float -mno-string -Wa,-me500 -O2" and
GLIBC_EXTRA_CONFIG=3D"--without-fp", but this is not building correctly
either. Any advice or recommendations are appreciated.

Clint

-----Original Message-----
From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
Sent: Friday, October 13, 2006 11:34 AM
To: Clint Thomas
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: GCC version to kernel version


On Oct 13, 2006, at 9:55 AM, Clint Thomas wrote:

> Hey guys,
>
> Generic question here. To each linux kernel version, is there a=20
> specific version of GCC and GLIBC I should be using to build the=20
> kernel, RFS, etc? I cannot seem to find any concrete proof that this=20
> is the case, but I am having issues building a new RFS with my older=20
> GCC and GLIBC, so I'm looking at updating them. I'm currently using=20
> GCC 3.3.2 and GLIBC 2.3.2 to build for the Linux 2.4.27 kernel on an=20
> e500 (MPC8541) core. Thanks!
>

It depends on what user space functionality you want/need form e500.  =20
If you plan on using SPE or fp I'd say to make sure to get tools chains
that support e500.  If you are just running normal integer code than any
toolchain should be fine.

- k
