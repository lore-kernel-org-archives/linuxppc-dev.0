Return-Path: <kumar.gala@freescale.com>
Received: from motgate7.mot.com (motgate7.mot.com [129.188.136.7])
	by ozlabs.org (Postfix) with ESMTP id CE88D2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Nov 2004 09:53:31 +1100 (EST)
In-Reply-To: <8E5ACAE05E6B9E44A2903C693A5D4E8A023EC8C0@hqemmail02.nvidia.com>
References: <8E5ACAE05E6B9E44A2903C693A5D4E8A023EC8C0@hqemmail02.nvidia.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4F87E4F8-3CD9-11D9-B55F-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 22 Nov 2004 16:53:22 -0600
To: "Ratin Kumar" <RKumar@nvidia.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: (no subject)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ratin,

I would suggest looking at Dan Kegel's crosstool @ 
http://www.kegel.com/crosstool/.  Very helpful in pairing various parts 
of the GNU toolchain together to get a working version.  For MPC5200 
you want the ppc750 build.

- kumar

On Nov 22, 2004, at 1:23 PM, Ratin Kumar wrote:

> Hi,
>
> I am trying to build a toolchain for MPC5200 using gcc 3.4.1.
>
> The bootstrap compiler build fails with a complain that it could not 
> locate "signal.h". This happens even though I have the kernel headers 
> (with signal.h) installed. A quick search on google shows that some 
> other people have also run into this issue, although no 
> patches/sloution appears. Any ideas??
>
> Also, has anyone tried using 3.4.1 compiler for kernel 2.4.23 ????
>
> What are the matching glibc and binutils to use with 3.4.1?? Any 
> patches??
>
> Thanks,
>  Rk.
> <ATT949193.txt>
