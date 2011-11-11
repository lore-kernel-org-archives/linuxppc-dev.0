Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (mail-va3.bigfish.com [216.32.180.10])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D32561007D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 03:39:31 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Kokoris, Ioannis" <ioannis.kokoris@siemens-enterprise.com>
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload
Date: Fri, 11 Nov 2011 16:39:21 +0000
Message-ID: <4EBD4FB8.2020406@freescale.com>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
In-Reply-To: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kokoris, Ioannis wrote:
> Hi,
>
> QE Microcode Initialization using qe_upload_microcode() does not work
> on P1021 if the IRAM-Ready register is not set after the microcode
> upload. This patch adds a definition for the "I-RAM Ready" register and
> sets it uppon microcode upload completion.

Will this code still work on other QE parts, like the MPC8323?

--=20
Timur Tabi
Linux kernel developer at Freescale=
