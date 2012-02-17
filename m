Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EDACB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 14:10:21 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Liu Qiang-B32616
 <B32616@freescale.com>
Subject: RE: [PATCH V2 RESEND] fsl-sata: I/O load balancing
Date: Fri, 17 Feb 2012 03:09:54 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0574273C@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1329284944-17943-1-git-send-email-qiang.liu@freescale.com>
 <1329439216.2892.36.camel@pasglop>
In-Reply-To: <1329439216.2892.36.camel@pasglop>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 "jgarzik@pobox.com" <jgarzik@pobox.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>I tried a debian install on the p5020ds here and I find SATA to be
>extremely slow, generating millions of interrupts. I think the defaults
>should be a lot more aggressive at coalescing.

The P5020 has a hardware problem with SATA, making it generate more interru=
pts than it should.  A new revision of the silicon will fix it.

- Leo
