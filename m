Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4C029DE005
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 01:06:12 +1000 (EST)
Message-Id: <145E9591-8A14-43B1-9D31-06B213B454E7@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
Date: Tue, 7 Apr 2009 10:05:45 -0500
References: <b0b55030b7ba669cbdec74a8b89875096ea07622.1239069602.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 6, 2009, at 9:00 PM, Michael Ellerman wrote:

> Add an option, on by default, to build all code under arch/powerpc  
> with
> -Werror, which causes gcc to treat warnings as errors.
>
> The intention is to make it harder for people to inadvertantly  
> introduce
> errors in the arch/powerpc code. It needs to be configurable so that
> if a warning is introduced, people can easily work around it while  
> it's
> being fixed.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/Kconfig.debug      |    8 ++++++++
> arch/powerpc/kernel/Makefile    |    4 ++++
> arch/powerpc/kvm/Makefile       |    4 ++++
> arch/powerpc/lib/Makefile       |    4 ++++
> arch/powerpc/mm/Makefile        |    4 ++++
> arch/powerpc/oprofile/Makefile  |    4 ++++
> arch/powerpc/platforms/Makefile |    4 ++++
> arch/powerpc/sysdev/Makefile    |    4 ++++
> arch/powerpc/xmon/Makefile      |    4 ++++
> 9 files changed, 40 insertions(+), 0 deletions(-)
>
> v2: Leave math-emu alone, it's a steaming pile of warnings.

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
