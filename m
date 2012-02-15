Return-Path: <pku.leo@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D355E1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 18:51:26 +1100 (EST)
Received: by eaan11 with SMTP id n11so229984eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2012 23:51:23 -0800 (PST)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1329291634-883-1-git-send-email-qiang.liu@freescale.com>
References: <1329291634-883-1-git-send-email-qiang.liu@freescale.com>
Date: Wed, 15 Feb 2012 15:51:23 +0800
Message-ID: <CADRPPNTmRvPVymJmW4vagU+2M4DmqeDSEj=4=R_=YDJekOTccQ@mail.gmail.com>
Subject: Re: [PATCH V3] fsl-sata: add support for interrupt coalsecing feature
From: Li Yang <leoli@freescale.com>
To: Qiang Liu <qiang.liu@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jgarzik@pobox.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 15, 2012 at 3:40 PM, Qiang Liu <qiang.liu@freescale.com> wrote:
> Adds support for interrupt coalescing feature to reduce interrupt events.
> Provides a mechanism of adjusting coalescing count and timeout tick by sysfs
> at runtime, so that tradeoff of latency and CPU load can be made depending
> on different applications.
>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>

Acked-by: Li Yang <leoli@freescale.com>

- Leo
