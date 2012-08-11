Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DD0C82C0694
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 23:11:14 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH V6 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Sat, 11 Aug 2012 13:11:07 +0000
Message-ID: <CAOZdJXW_mcx89v9hqp21D0baXYpqFtXLmo0VPtQTfMof9wn7UA@mail.gmail.com>
References: <1344586776-3115-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1344586776-3115-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 10, 2012 at 3:19 AM, Jia Hongtao <B38951@freescale.com> wrote:
>
> +EXPORT_SYMBOL_GPL(mpc85xx_pci_err_probe);

Make this EXPORT_SYMBOL.

--=20
Timur Tabi
Linux kernel developer at Freescale=
