Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2514AB6F81
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2011 12:52:08 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: clean up FPGA device tree nodes for
	Freecsale QorIQ boards
Date: Wed, 31 Aug 2011 02:51:57 +0000
Message-ID: <4E5DA1CC.1020808@freescale.com>
References: <1314644999-16955-1-git-send-email-timur@freescale.com>
	<3F34FBCD-3F0B-4D59-A947-C16CC812B42E@freescale.com>
In-Reply-To: <3F34FBCD-3F0B-4D59-A947-C16CC812B42E@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Do we really want the generic "fsl,fpga-cpld"&  "fsl,fpga-pixis"?  This s=
eems to vague.

Yes, the PIXIS is generally register compatible across all boards.  There=20
may be some minor differences, but the OCM driver can work with all PIXIS=20
boards that have an PIXIS.

>  Also you need "pixis" on MPC8544DS, MPC8572DS, MPC8536DS.

Ok.

> Also fpga-cpld makes no sense if we keep this.  You are either a CPLD or =
FPGA not both.

Then I don't understand what the CPLD is.

--=20
Timur Tabi
Linux kernel developer at Freescale=
