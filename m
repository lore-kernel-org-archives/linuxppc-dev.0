Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DE58B6F8A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 12:54:07 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <4E5DA1CC.1020808@freescale.com>
Date: Tue, 30 Aug 2011 21:54:05 -0500
Message-ID: <DBF3606B-8F59-4E5F-9B47-C3E0235665C4@freescale.com>
References: <1314644999-16955-1-git-send-email-timur@freescale.com>
	<3F34FBCD-3F0B-4D59-A947-C16CC812B42E@freescale.com>
	<4E5DA1CC.1020808@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 30, 2011, at 9:51 PM, Tabi Timur-B04825 wrote:

> Kumar Gala wrote:
>> Do we really want the generic "fsl,fpga-cpld"&  "fsl,fpga-pixis"?  =
This seems to vague.
>=20
> Yes, the PIXIS is generally register compatible across all boards.  =
There=20
> may be some minor differences, but the OCM driver can work with all =
PIXIS=20
> boards that have an PIXIS.

Is this true?  Don't we have pixis and ngpixis in u-boot?

>> Also you need "pixis" on MPC8544DS, MPC8572DS, MPC8536DS.
>=20
> Ok.
>=20
>> Also fpga-cpld makes no sense if we keep this.  You are either a CPLD =
or FPGA not both.
>=20
> Then I don't understand what the CPLD is.

http://en.wikipedia.org/wiki/Complex_programmable_logic_device

- k=
