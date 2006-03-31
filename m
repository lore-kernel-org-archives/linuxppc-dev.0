Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 65DE8679F6
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Apr 2006 05:35:58 +1100 (EST)
Received: from White64 (p54B4B5BE.dip0.t-ipconnect.de [84.180.181.190])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id k2VIajl12510
	for <linuxppc-embedded@ozlabs.org>; Fri, 31 Mar 2006 20:36:56 +0200
Date: Fri, 31 Mar 2006 20:36:34 +0200
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200b and floating point
Message-ID: <20060331203634.3818e8af@White64>
In-Reply-To: <20060331133619.GD7738@localhost.localdomain>
References: <20060331133619.GD7738@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Fri, 31 Mar 2006 15:36:20 +0200 schrieb Sascha Hauer
<s.hauer@pengutronix.de> :

Please check your Toolchain.
Have you build it ?

Do you use glibc or something like uclibc ?

At my beginning with mpc5200 i hat simular problems.

I had the wrong Compilerflags during build of my ToolChain.
(uclibc).

Good Luck.

> Hi,
> 
> I'm working with a mpc5200b custom board and I'm trying to run an
> application with floating point. All floating point variables seem to
> zero all the time. Since I'm not very familiar with powerpc it might be
> something stupid I have overlooked.
> Any hints?
> 
> Thank you,
> 
>   Sascha Hauer
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
