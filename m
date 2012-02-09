Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A31A7B6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 03:04:22 +1100 (EST)
Received: from mail65-am1 (localhost [127.0.0.1])	by mail65-am1-R.bigfish.com
 (Postfix) with ESMTP id A6A762C042C	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Feb 2012 16:04:15 +0000 (UTC)
Received: from AM1EHSMHS019.bigfish.com (unknown [10.3.201.246])	by
 mail65-am1.bigfish.com (Postfix) with ESMTP id AD0E3240048	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 16:04:13 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Craciun Diana Madalina-STFD002 <STFD002@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Removed fsl,msi property from dts.
Date: Thu, 9 Feb 2012 16:04:04 +0000
Message-ID: <CAOZdJXWugjpC1pG=x6H9t4C=JM1Jp-dS0-+keyMa3AwB-kEv2w@mail.gmail.com>
References: <1328794860-12592-1-git-send-email-diana.craciun@freescale.com>
In-Reply-To: <1328794860-12592-1-git-send-email-diana.craciun@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 9, 2012 at 7:41 AM, Diana Craciun
<diana.craciun@freescale.com> wrote:
> From: Diana CRACIUN <Diana.Craciun@freescale.com>
>
> The association in the decice tree between PCI and MSI
> using fsl,msi property was an artificial one and it does
> not reflect the actual hardware.
>
> Signed-off-by: Diana CRACIUN <Diana.Craciun@freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale=
