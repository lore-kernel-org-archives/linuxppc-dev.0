Return-Path: <Amit.Tomar@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0146.outbound.protection.outlook.com [65.55.169.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 393F71A0655
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Dec 2014 16:02:52 +1100 (AEDT)
From: Amit Tomar <Amit.Tomar@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [Patch] :Fix ISR return value in i2c-mpc.c
Date: Sat, 13 Dec 2014 05:02:43 +0000
Message-ID: <1418463159211.45307@freescale.com>
References: <BL2PR03MB4495ADAE7D752F82B58B1D783600@BL2PR03MB449.namprd03.prod.outlook.com>
 <BL2PR03MB4496E03E1930685FD2A4FD483600@BL2PR03MB449.namprd03.prod.outlook.com>,
 <1418418631.5581.68.camel@freescale.com>
In-Reply-To: <1418418631.5581.68.camel@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry for sending it to wrong mailing-list :(=0A=
=0A=
Thanks,=0A=
Amit.=0A=
________________________________________=0A=
From: Wood Scott-B07421=0A=
Sent: Saturday, December 13, 2014 2:40 AM=0A=
To: Tomar Amit-B51888=0A=
Cc: linuxppc-dev@lists.ozlabs.org; agraf@suse.de=0A=
Subject: Re: [Patch] :Fix ISR return value in i2c-mpc.c=0A=
=0A=
On Fri, 2014-12-12 at 11:17 +0000, Amit Tomar wrote:=0A=
> In current scenario, ISR of i2c-mpc.c is returning IRQ_HANDLED for doing =
nothing which is not right .=0A=
>=0A=
> With below patch ISR now return IRQ_NONE for doing nothing and IRQ_HANDLE=
D for doing handler work.=0A=
=0A=
Wrap the commit message at around 65-70 characters, change the subject=0A=
to "[PATCH] i2c/mpc: Fix ISR return value", and send to the proper=0A=
mailing list/maintainers for i2c (see the MAINTAINERS file).=0A=
=0A=
-Scott=0A=
=0A=
=0A=
