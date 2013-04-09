Return-Path: <R1AAHA@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A5AE2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 08:35:38 +1000 (EST)
Date: Tue, 9 Apr 2013 17:31:58 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Vakul Garg <vakul@freescale.com>
Subject: Re: [PATCH] powerpc/crypto: Add property for 'era' in SEC dts
 crypto node
Message-ID: <20130409173158.5eb44856b3304a34b6060dbf@freescale.com>
In-Reply-To: <1365508233-26292-1-git-send-email-vakul@freescale.com>
References: <1365508233-26292-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Shaveta Leekha <shaveta@freescale.com>, linux-kernel@vger.kernel.org,
 Andy Fleming <afleming@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Apr 2013 17:20:33 +0530
Vakul Garg <vakul@freescale.com> wrote:

> The crypto node now contains a new property 'fsl,sec-era'.
> This is required so that applications can retrieve era info without
> having to be able to read SEC's register space.
> 
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi   |    1 +
>  arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/qoriq-sec5.0-0.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/qoriq-sec5.2-0.dtsi |    1 +
>  arch/powerpc/boot/dts/fsl/qoriq-sec5.3-0.dtsi |    1 +
>  6 files changed, 6 insertions(+), 0 deletions(-)

missing p1023si-post.dtsi and qoriq-sec4.1-0.dtsi files.

Kim
