Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1860B1007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 11:43:41 +1100 (EST)
Received: from mail6-db3 (localhost [127.0.0.1])	by mail6-db3-R.bigfish.com
 (Postfix) with ESMTP id 896F63A0376	for <linuxppc-dev@ozlabs.org>; Tue, 13
 Dec 2011 00:43:34 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.240])	by
 mail6-db3.bigfish.com (Postfix) with ESMTP id 715AE44004B	for
 <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 00:43:34 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add MSI support for the Freescale hypervisor
Date: Tue, 13 Dec 2011 00:43:34 +0000
Message-ID: <4EE69FB4.5080705@freescale.com>
References: <1323733052-21495-1-git-send-email-timur@freescale.com>
 <4EE693C9.3080009@freescale.com> <4EE69BEB.8020208@freescale.com>
 <4EE69ED1.6040302@freescale.com>
In-Reply-To: <4EE69ED1.6040302@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> How's the hypervisor even going to know if the mem=3D kernel command line
> argument is used to change the end of main memory (assuming that's been
> taken into account by this point in the boot sequence)?
>
> What if the user put a shared memory region immediately after the main
> partition memory?

Alright, I'll need to add support for detached MSIIR addresses, but for=20
now I think this patch is okay.  It's the same level of functionality that=
=20
we provide on the SDK.

--=20
Timur Tabi
Linux kernel developer at Freescale=
