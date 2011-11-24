Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7951D1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:55:26 +1100 (EST)
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXXOrSaUgynqu+CL64SnivtOWHBDMcJK9Fh000M_JBK58Q@mail.gmail.com>
Date: Thu, 24 Nov 2011 01:55:16 -0600
Message-Id: <DF5BDBFF-A726-4E1C-832E-EF2629F60DC9@kernel.crashing.org>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
 <4EBD4FB8.2020406@freescale.com>
 <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
 <CAOZdJXXOrSaUgynqu+CL64SnivtOWHBDMcJK9Fh000M_JBK58Q@mail.gmail.com>
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


On Nov 15, 2011, at 9:02 PM, Tabi Timur-B04825 wrote:

> On Mon, Nov 14, 2011 at 2:55 AM, Kokoris, Ioannis
> <ioannis.kokoris@siemens-enterprise.com> wrote:
>> Ready register is needed for ROM-less devices such as P1021, MPC859, =
MPC8306 etc.
>> For ROM-based devices such as MCP8323 the Ready register does not =
exist.
>> Is there a global definition for conditionally including this code?
>=20
> I'll have to check.  But this patch can't be applied as-is unless it's
> proven safe for all QE-enabled chips.

Any update on trying this on a MPC8323?

- k=
