Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJdp85v5lzDrRl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 16:13:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Zhao Qiang <qiang.zhao@nxp.com>, oss@buserror.net
Cc: valentin.longchamp@keymile.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>
Subject: Re: [PATCH v2] qe: fix compile issue for arm64
In-Reply-To: <1500867555-36277-1-git-send-email-qiang.zhao@nxp.com>
References: <1500867555-36277-1-git-send-email-qiang.zhao@nxp.com>
Date: Fri, 28 Jul 2017 16:13:52 +1000
Message-ID: <87o9s5dr6n.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zhao Qiang <qiang.zhao@nxp.com> writes:

> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2:
> 	- include all Errata QE_General4 in #ifdef
>
>  drivers/soc/fsl/qe/qe.c | 2 ++
>  1 file changed, 2 insertions(+)

AFAICS this driver can only be built on PPC, what am I missing?

config QUICC_ENGINE
        bool "Freescale QUICC Engine (QE) Support"
        depends on FSL_SOC && PPC32

cheers
