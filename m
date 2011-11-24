Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id ACD001007E5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 00:57:47 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload
Date: Thu, 24 Nov 2011 13:57:31 +0000
Message-ID: <0154F680-D9F4-4CE1-BF5E-11884AD0ED4A@freescale.com>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
 <4EBD4FB8.2020406@freescale.com>
 <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
 <CAOZdJXXOrSaUgynqu+CL64SnivtOWHBDMcJK9Fh000M_JBK58Q@mail.gmail.com>
 <DF5BDBFF-A726-4E1C-832E-EF2629F60DC9@kernel.crashing.org>
In-Reply-To: <DF5BDBFF-A726-4E1C-832E-EF2629F60DC9@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kokoris,
 Ioannis" <ioannis.kokoris@siemens-enterprise.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 24, 2011, at 1:55 AM, Kumar Gala <galak@kernel.crashing.org> wrote:

>>=20
>> I'll have to check.  But this patch can't be applied as-is unless it's
>> proven safe for all QE-enabled chips.
>=20
> Any update on trying this on a MPC8323?

Haiying said it should be ok, but I haven't tried it yet.  I'll try it on M=
onday.
