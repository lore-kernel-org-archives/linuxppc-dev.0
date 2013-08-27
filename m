Return-Path: <B21989@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 120232C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 20:51:32 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Anthony Foiani <tkil@scrye.com>
Subject: RE: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
Date: Tue, 27 Aug 2013 10:51:25 +0000
Message-ID: <ED492CCEAF882048BC2237DE806547C91506316E@039-SN2MPN1-012.039d.mgd.msft.net>
References: <20130823192532.GA29205@home.buserror.net>
In-Reply-To: <20130823192532.GA29205@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>, Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> As for the property name, I'd prefer "fsl,sata-speed-limit" or "fsl,sata-
> max-generation".  Shaohui, do the driver bits look OK?
[S.H] The driver part is OK.=20
I also tested it on p5040, the SATA worked as expected.

Best Regards,=20
Shaohui Xie
