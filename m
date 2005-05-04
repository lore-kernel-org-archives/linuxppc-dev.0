Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 940B0679EA
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2005 04:08:18 +1000 (EST)
In-Reply-To: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <3ef0069e8d123c43579a8cc85d20467c@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 4 May 2005 08:45:51 -0500
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2005, at 2:05 AM, Paul Mackerras wrote:

> What do people think of this patch?=A0 The motivation for it is that a
>  biarch gcc-4.0 will by default tune for POWER4, even for a 32-bit
>  compile, meaning that we end up with a lot of nops we don't need.
>  This also takes out -mstring.
>
> With this, the text size reduces by about 120k for my normal config
>  when compiling with a biarch gcc-4.0.=A0 The text size also reduces
>  slightly when compiling with the Debian gcc-3.3.5 (32-bit only, not
>  biarch).

What is attributed to this large of a text size change.  I've always=20
assumed the -mcpu and -mtune options really only effected code=20
scheduling.  This seems really odd since there arent really that many=20
different instructions between the various PPC variants.

- kumar=
