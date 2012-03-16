Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8EF3FB70A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:24:48 +1100 (EST)
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0154F680-D9F4-4CE1-BF5E-11884AD0ED4A@freescale.com>
Date: Fri, 16 Mar 2012 10:21:12 -0500
Message-Id: <AC087E7A-B7BC-43E5-948F-68AEB8251FD3@kernel.crashing.org>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
 <4EBD4FB8.2020406@freescale.com>
 <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
 <CAOZdJXXOrSaUgynqu+CL64SnivtOWHBDMcJK9Fh000M_JBK58Q@mail.gmail.com>
 <DF5BDBFF-A726-4E1C-832E-EF2629F60DC9@kernel.crashing.org>
 <0154F680-D9F4-4CE1-BF5E-11884AD0ED4A@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
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


On Nov 24, 2011, at 7:57 AM, Tabi Timur-B04825 wrote:

> On Nov 24, 2011, at 1:55 AM, Kumar Gala <galak@kernel.crashing.org> =
wrote:
>=20
>>>=20
>>> I'll have to check.  But this patch can't be applied as-is unless =
it's
>>> proven safe for all QE-enabled chips.
>>=20
>> Any update on trying this on a MPC8323?
>=20
> Haiying said it should be ok, but I haven't tried it yet.  I'll try it =
on Monday.

Did you ever test this?

- k=
