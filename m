Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 621622C008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 14:11:54 +1000 (EST)
Received: from mail234-va3 (localhost [127.0.0.1])	by
 mail234-va3-R.bigfish.com (Postfix) with ESMTP id A2E83B0034D	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 04:11:49 +0000 (UTC)
Received: from VA3EHSMHS027.bigfish.com (unknown [10.7.14.245])	by
 mail234-va3.bigfish.com (Postfix) with ESMTP id 14ED6280047	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Aug 2012 04:11:48 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH V4 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Mon, 6 Aug 2012 04:11:34 +0000
Message-ID: <CAOZdJXWFPn2XqyTR4jUkUZ5NV-h7HRWcnm392qUYJ98tg8H7Ow@mail.gmail.com>
References: <1343907741-20589-1-git-send-email-B38951@freescale.com>
 <1343907741-20589-4-git-send-email-B38951@freescale.com>
 <501AE0A2.4010809@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A359AF@039-SN1MPN1-002.039d.mgd.msft.net>
 <501BF7BC.1030208@freescale.com>
In-Reply-To: <501BF7BC.1030208@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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

On Fri, Aug 3, 2012 at 11:09 AM, Scott Wood <scottwood@freescale.com> wrote=
:

> p1022ds OTOH is weird enough that it deserves its own board file.

What's so weird about the P1022DS?

Also, why do we need a default PCI bus if one isn't specified in the
device tree?

--=20
Timur Tabi
Linux kernel developer at Freescale=
