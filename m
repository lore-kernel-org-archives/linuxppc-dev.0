Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 6E3E5B6F85
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2011 07:40:52 +1100 (EST)
Received: from mail21-ch1 (localhost.localdomain [127.0.0.1])	by
 mail21-ch1-R.bigfish.com (Postfix) with ESMTP id 7C884B204A3	for
 <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 20:40:41 +0000 (UTC)
Received: from CH1EHSMHS012.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.250])	by mail21-ch1.bigfish.com (Postfix) with ESMTP id
 51EFD6E8067
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2011 20:40:39 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: do not force PHYS_64BIT on Freescale
 reference boards
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4EB2E4F0.8040108@freescale.com>
Date: Thu, 3 Nov 2011 15:40:44 -0500
Message-ID: <379CBBC8-D3FA-44CB-9461-0AFB552956BE@freescale.com>
References: <1320346215-21024-1-git-send-email-timur@freescale.com>
 <C957F668-1C3A-40CB-9505-27B4D6966751@freescale.com>
 <4EB2E4F0.8040108@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 3, 2011, at 2:01 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>> Nak.  For certain boards like P204x-P50xx we only support a 36-bit =
address map.
>=20
> I understand that we don't supply a 32-bit U-boot or device tree, but =
is
> there any hard requirement that we force 36-bit kernels?  If it's =
really a
> requirement, then adding to the Kconfig of each board doesn't sound =
like
> the best way to enforce this.

Yes, there is a requirement.  Why would we allow you to build support =
for a board and not have it boot?  The Kconfig is exactly how to enforce =
this.

- k=
