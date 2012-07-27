Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66D352C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 11:34:32 +1000 (EST)
Message-ID: <5011F01C.8000008@freescale.com>
Date: Thu, 26 Jul 2012 20:34:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao-B38951 <B38951@freescale.com>
Subject: Re: [PATCH 3/6] powerpc/fsl-pci: Determine primary bus by looking
 for ISA node
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-3-git-send-email-B38951@freescale.com>
 <500EEDD9.8050507@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A275B4@039-SN1MPN1-002.039d.mgd.msft.net>
 <50102C27.8040004@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A27C7D@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01A27C7D@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2012 09:20 PM, Jia Hongtao-B38951 wrote:
> All this recursion thing I will try another way.
> 
> But this is not the same as you did. If we use platform driver probe function
> will be called more than once. Your function is to find ISA node and check if
> the parent equal to this PCI controller. My function is to search ISA under
> each PCI controller.

The result is the same -- "does this PCI controller have an ISA node
under it?"

-Scott
