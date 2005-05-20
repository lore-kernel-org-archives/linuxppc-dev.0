Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8808D679FB
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2005 01:00:02 +1000 (EST)
In-Reply-To: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
References: <17037.32285.607543.859030@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d711f981871bb288a61b7244c0f6d428@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 20 May 2005 09:59:54 -0500
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu type explicitly, take 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2005, at 1:05 AM, Paul Mackerras wrote:

> Here is a revised version of my patch to set the cpu type explicitly
> for gcc when compiling the kernel.  Setting the cpu type is a good
> idea in any case, and particularly if you have a biarch gcc.  This
> sets the type for all of the ppc cpu families we support.
>
> Any further comments?  Are -mcpu=860 and -mcpu=8540 reasonable for 8xx
> and 85xx respectively?  I used -mcpu=power4 rather than -mcpu=970
> because the former works with gcc-3.6.6 as in debian and the latter
> doesn't.  Unfortunately -mcpu=440 doesn't work either in gcc 3.3,
> though it does in gcc 3.4 (as does -mcpu=970).

Yes, -mcpu=8540 is reasonable for 85xx.

- kumar
