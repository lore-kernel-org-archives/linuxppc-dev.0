Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id D7AFDDE0CC
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 06:38:30 +1100 (EST)
Message-ID: <496CED98.1040902@am.sony.com>
Date: Tue, 13 Jan 2009 11:38:00 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Enable PS3 options and QPACE in ppc64_defconfig
References: <e613c8e37489239652a88cfa34741447530f2415.1231813731.git.michael@ellerman.id.au>
In-Reply-To: <e613c8e37489239652a88cfa34741447530f2415.1231813731.git.michael@ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> To increase the amount of code that's built for a defconfig build.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/configs/ppc64_defconfig |   26 +++++++++++++++++++++++++-
>  1 files changed, 25 insertions(+), 1 deletions(-)

> -# CONFIG_PPC_PS3 is not set
> +CONFIG_PPC_PS3=y

I tested this ppc64_defconfig, and it could boot on PS3.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
