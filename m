Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4E520B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 07:30:37 +1100 (EST)
Received: from mail44-va3 (localhost [127.0.0.1])	by mail44-va3-R.bigfish.com
 (Postfix) with ESMTP id D8AC75E01F2	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jan 2012 20:30:31 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.252])	by
 mail44-va3.bigfish.com (Postfix) with ESMTP id A1D995C004E	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 20:30:30 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH] DTS: fix the bug and add the chip compatible for eSDHC
Date: Mon, 2 Jan 2012 20:30:28 +0000
Message-ID: <CAOZdJXXXvTuJO_ZpyeRatWxTMbmcEVokA9qx7ajNdzKyiEgBhw@mail.gmail.com>
References: <1324620659-7135-1-git-send-email-r66093@freescale.com>
In-Reply-To: <1324620659-7135-1-git-send-email-r66093@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Huang Changming-R66093 <r66093@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 23, 2011 at 12:10 AM,  <r66093@freescale.com> wrote:
>
> Accordint to latest kernel, the auto-cmd12 property should be
> "sdhci,auto-cmd12", and according to the SDHC binding and the workaround =
for
> the special chip, add the chip compatible for eSDHC: "fsl,p1022-esdhc",
> "fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and "fsl,p1010-esdhc".

Please do not use the phrase "fix the bug" in patch summaries.

--=20
Timur Tabi
Linux kernel developer at Freescale=
