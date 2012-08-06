Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CA812C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2012 00:03:42 +1000 (EST)
Received: from mail74-co1 (localhost [127.0.0.1])	by mail74-co1-R.bigfish.com
 (Postfix) with ESMTP id 4053E78034B	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Aug 2012 14:03:38 +0000 (UTC)
Received: from CO1EHSMHS015.bigfish.com (unknown [10.243.78.227])	by
 mail74-co1.bigfish.com (Postfix) with ESMTP id 9C8A014004E	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 14:03:36 +0000 (UTC)
Message-ID: <501FCEB8.1040506@freescale.com>
Date: Mon, 6 Aug 2012 09:03:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
 <501AE0A2.4010809@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A359AF@039-SN1MPN1-002.039d.mgd.msft.net>
 <501BF7BC.1030208@freescale.com>
 <CAOZdJXWFPn2XqyTR4jUkUZ5NV-h7HRWcnm392qUYJ98tg8H7Ow@mail.gmail.com>
In-Reply-To: <CAOZdJXWFPn2XqyTR4jUkUZ5NV-h7HRWcnm392qUYJ98tg8H7Ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2012 11:11 PM, Tabi Timur-B04825 wrote:
> On Fri, Aug 3, 2012 at 11:09 AM, Scott Wood <scottwood@freescale.com> wrote:
> 
>> p1022ds OTOH is weird enough that it deserves its own board file.
> 
> What's so weird about the P1022DS?

The localbus muxing.

> Also, why do we need a default PCI bus if one isn't specified in the
> device tree?

Because there are bugs in the Linux PPC PCI code when you don't have a
primary bus -- see recent upstream linuxppc-dev discussion.

-Scott
