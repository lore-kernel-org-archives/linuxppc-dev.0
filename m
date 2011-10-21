Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
 [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 4BFE5B71C1
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Oct 2011 06:19:09 +1100 (EST)
Received: from mail110-db3 (localhost.localdomain [127.0.0.1])	by
 mail110-db3-R.bigfish.com (Postfix) with ESMTP id 8A23A8C84C3	for
 <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 19:19:03 +0000 (UTC)
Received: from DB3EHSMHS016.bigfish.com (unknown [10.3.81.245])	by
 mail110-db3.bigfish.com (Postfix) with ESMTP id 3E6CC10C81EE	for
 <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 19:17:01 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] powerpc/fsl_msi: add support for "msi-address-64" property
Date: Fri, 21 Oct 2011 19:16:58 +0000
Message-ID: <CAOZdJXVJXhiSsjm9cBruGgJ946fr6xwpOZzTLcN2GQGq6eamVw@mail.gmail.com>
References: <1316799695-31376-1-git-send-email-timur@freescale.com>
 <C4D76656-C95E-4906-BC65-6EBAFBBB6A7C@freescale.com>
In-Reply-To: <C4D76656-C95E-4906-BC65-6EBAFBBB6A7C@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 14, 2011 at 9:15 AM, Kumar Gala <kumar.gala@freescale.com> wrot=
e:

>> .../devicetree/bindings/powerpc/fsl/msi-pic.txt =A0 =A0| =A0 42 ++++++++=
++++++++++++
>> arch/powerpc/sysdev/fsl_msi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 20 +++++++---
>> arch/powerpc/sysdev/fsl_msi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A03 +-
>> 3 files changed, 57 insertions(+), 8 deletions(-)
>
> applied

Applied where, exactly?  You don't have a repo on kernel.org, and your
repo on github.org is over a month old.

--=20
Timur Tabi
Linux kernel developer at Freescale=
