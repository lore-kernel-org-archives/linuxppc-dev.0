Return-Path: <r61911@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A27F12C10C9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 20:59:17 +1000 (EST)
Message-ID: <517193D3.1070506@freescale.com>
Date: Sat, 20 Apr 2013 02:58:27 +0800
From: Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-pci: fix setup_pci_atmu() parameter issue
References: <1366397734-1416-1-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1366397734-1416-1-git-send-email-tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2013 02:55 AM, Roy Zang wrote:
> setup_pci_atmu() only has one parameter and remove the extra one, or
> build will fail due to un-match.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
>
based on Kumar's next branch.
Roy
