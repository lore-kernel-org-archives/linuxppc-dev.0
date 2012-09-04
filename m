Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR003.ACS-INC.COM (usa7109mr003.acs-inc.com
 [63.101.151.12])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "usa7109mr.acs-inc.com",
 Issuer "USERTrust Legacy Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C2A02C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 22:00:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] sata_fsl: add workaround for data length mismatch on
 freescale V2 controller
Date: Tue, 4 Sep 2012 13:00:28 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB906C13480@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
References: <1346756920-19128-1-git-send-email-Shaohui.Xie@freescale.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: Shaohui Xie <Shaohui.Xie@freescale.com>, <jgarzik@pobox.com>,
 <linux-ide@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anju Bhartiya <Anju.Bhartiya@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> The freescale V2 SATA controller checks
> if the received data length matches
> the programmed length 'ttl', if not,
> it assumes that this is an error.
...

Can you tell us exactly what
"The freescale V2 SATA controller" is,
and what versions of what devices contain it?

Thanks,
Clive
