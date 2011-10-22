Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07F77B70C0
 for <linuxppc-dev@ozlabs.org>; Sun, 23 Oct 2011 08:19:27 +1100 (EST)
Subject: Re: [PATCH] powerpc/fsl_msi: add support for "msi-address-64" property
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXVJXhiSsjm9cBruGgJ946fr6xwpOZzTLcN2GQGq6eamVw@mail.gmail.com>
Date: Sat, 22 Oct 2011 16:19:18 -0500
Message-Id: <F4205ADA-3408-4807-9207-4FFC3866A8B7@kernel.crashing.org>
References: <1316799695-31376-1-git-send-email-timur@freescale.com>
 <C4D76656-C95E-4906-BC65-6EBAFBBB6A7C@freescale.com>
 <CAOZdJXVJXhiSsjm9cBruGgJ946fr6xwpOZzTLcN2GQGq6eamVw@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 21, 2011, at 2:16 PM, Tabi Timur-B04825 wrote:

> On Fri, Oct 14, 2011 at 9:15 AM, Kumar Gala <kumar.gala@freescale.com> =
wrote:
>=20
>>> .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |   42 =
++++++++++++++++++++
>>> arch/powerpc/sysdev/fsl_msi.c                      |   20 +++++++---
>>> arch/powerpc/sysdev/fsl_msi.h                      |    3 +-
>>> 3 files changed, 57 insertions(+), 8 deletions(-)
>>=20
>> applied
>=20
> Applied where, exactly?  You don't have a repo on kernel.org, and your
> repo on github.org is over a month old.


I've updated github as still trying to figure out when I'll get my =
kernel.org account back.

- k=
