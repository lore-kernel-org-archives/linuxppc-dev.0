Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7E90CDDE9D
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 00:46:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 23/28] mpc82xx: Define CPU_FTR_NEED_COHERENT
Date: Tue, 18 Sep 2007 09:34:31 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0360A803@ismail.innsys.innovsys.com>
In-Reply-To: <20070917165815.GW6563@loki.buserror.net>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165815.GW6563@loki.buserror.net>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Scott Wood" <scottwood@freescale.com>,
	<galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Scott Wood
> Sent: Monday, September 17, 2007 11:58 AM
>=20
> The 8272 (and presumably other PCI PQ2 chips) appear to have the
> same issue as the 83xx regarding PCI streaming DMA.
>=20

Can you explain what this isssue is? We're using a 8280 and have had
some PCI busmaster DMA problems, and wonder if it is related.
