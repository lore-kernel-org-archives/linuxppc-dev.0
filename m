Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 05819DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:35:20 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC8349ea Random Device Generator driver
Date: Thu, 7 Jun 2007 00:35:15 +0200
References: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
	<200706070011.43347.arnd@arndb.de> <466732EE.8080306@freescale.com>
In-Reply-To: <466732EE.8080306@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706070035.16150.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, sl@powerlinux.fr,
	Timur Tabi <timur@freescale.com>,
	Philippe Lachenal <philippe.lachenal@hotmail.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007, Timur Tabi wrote:
> Anyway, there's a more fundamental problem. =A0I can't find any 64-bit ve=
rsions of the=20
> in_be/out_be/read/write functions. =A0Because the registers are big-endia=
n, then we have a=20
> few choices:

> 1) Create 64-bit versions of these functions.  Can someone tell me why th=
ey don't exist=20
> already?

There are there on my system, see in_be64/out_be64/readq/writeq. note that =
the code
for those is created by macros, so they don't show up in ctags.

	Arnd <><
