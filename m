Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76DEC2C029B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 10:13:56 +1000 (EST)
Received: from mail213-co9 (localhost [127.0.0.1])	by
 mail213-co9-R.bigfish.com (Postfix) with ESMTP id 52006A01AA	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:13:52 +0000 (UTC)
Received: from CO9EHSMHS019.bigfish.com (unknown [10.236.132.246])	by
 mail213-co9.bigfish.com (Postfix) with ESMTP id E683E2E0056	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 00:13:50 +0000 (UTC)
Date: Mon, 17 Jun 2013 19:13:48 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/5] powerpc/dts: remove msi-available-ranges property
To: Lian Minghuan-b31939 <B31939@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-4-git-send-email-Minghuan.Lian@freescale.com>
 <1371247853.2996.17@snotra> <51BE9B78.9080302@freescale.com>
In-Reply-To: <51BE9B78.9080302@freescale.com> (from B31939@freescale.com on
 Mon Jun 17 00:15:36 2013)
Message-ID: <1371514428.9073.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2013 12:15:36 AM, Lian Minghuan-b31939 wrote:
> On 06/15/2013 06:10 AM, Scott Wood wrote:
>> On 06/14/2013 02:15:58 AM, Minghuan Lian wrote:
>>> For MPIC v4.3 MSIIR supports 8 MSI registers and MSIIR1 supports
>>> 16 MSI registers, but uses different IBS and SRS shift. For the
>>> first register, when using MSIIR we will get the irqs 0x0 0x1 0x2
>>> ...0x1f, but when using MSIIR1, the irqs are 0x0 0x10 0x20 ... 0x1f0
>>> It is hard to describe the available irqs using property
>>> 'msi-available-ranges'. The patch removes this property.
>>=20
>> Only remove it from mpic 4.3.  And since you introduced =20
>> qoriq-mpic4.3.dtsi earlier in the patchset, why didn't you just =20
>> avoid adding it then?
>>=20
> [Minghuan] If adding it in qoriq-mpic4.3, and the 3-5 patches are not =20
> accepted, mpic4.3 can also work.

mpic 4.3 cannot work with msi-available-ranges, at all.  The hardware =20
just doesn't work that way.

-Scott=
