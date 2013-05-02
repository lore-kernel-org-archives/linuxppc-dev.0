Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 396CA2C00C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 03:04:00 +1000 (EST)
Date: Thu, 2 May 2013 12:03:44 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 V8] powerpc/85xx: Add machine check handler to fix
 PCIe erratum on mpc85xx
To: Jia Hongtao <hongtao.jia@freescale.com>
References: <1367126408-12997-1-git-send-email-hongtao.jia@freescale.com>
 <1367126408-12997-2-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1367126408-12997-2-git-send-email-hongtao.jia@freescale.com>
 (from hongtao.jia@freescale.com on Sun Apr 28 00:20:08 2013)
Message-ID: <1367514224.24411.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: B07421@freescale.com, hongtao.jia@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2013 12:20:08 AM, Jia Hongtao wrote:
> A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> goes down. when the link goes down, Non-posted transactions issued
> via the ATMU requiring completion result in an instruction stall.
> At the same time a machine-check exception is generated to the core
> to allow further processing by the handler. We implements the handler
> which skips the instruction caused the stall.
>=20
> This patch depends on patch:
> powerpc/85xx: Add platform_device declaration to fsl_pci.h
>=20
> Signed-off-by: Zhao Chenhui <b35336@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Liu Shuo <soniccat.liu@gmail.com>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
> V8:
> * Add A variant load instruction emulation.

ACK

-Scott=
