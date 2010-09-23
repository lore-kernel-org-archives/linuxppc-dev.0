Return-Path: <david.hagood@gmail.com>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 965A4B70D2
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 00:44:14 +1000 (EST)
Received: by yxt33 with SMTP id 33so1006861yxt.15
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Sep 2010 07:44:12 -0700 (PDT)
Message-ID: <409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>
In-Reply-To: <52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
	<1285240268.2454.8.camel@chumley>
	<52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>
Date: Thu, 23 Sep 2010 09:44:09 -0500
Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
From: david.hagood@gmail.com
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, David Hagood <david.hagood@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> -----Original Message-----
 via the BARs.
>
> I read your email again and something hint me. I notice you clarify you
> already condigure InBound successfully.

I am programming BOTH the inbound ATMUs to make PPC memory available to
the root complex, AND programming outbound ATMUs to enable the PPC to bus
master to the root complex's memory space on PCIe.

I am NOT attempting to program the IWBARs - as you noted, they get
programmed by the root complex via PCI config operations.

>
>  And as my above comment I'm afraid you
> mix up InBound and OutBound on EP mode?

No, I am NOT confusing the two - that is why I am being VERY EXPLICIT
about accessing the OUTBOUND ATMUs.

The only reason I mention the inbound ATMUs is to demonstrate that the
physical layer is working.
