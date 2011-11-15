Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR002.ACS-INC.COM (usa7109mr002.acs-inc.com
 [63.101.151.11])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "usa7109mr.acs-inc.com", Issuer "GeoTrust DV SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 900C2B6F8B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2011 22:37:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/3] mtd/nand: fix coding style issue in
 drivers/mtd/nand/fsl_elbc.c
Date: Tue, 15 Nov 2011 11:26:06 -0000
Message-ID: <929D3CED81F34E43887A393170D66FB9053A8C82@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <1321349355-1639-1-git-send-email-b35362@freescale.com>
References: <1321349355-1639-1-git-send-email-b35362@freescale.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: <b35362@freescale.com>, <dwmw2@infradead.org>, <Artem.Bityutskiy@nokia.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> fix whitespaces,tabs coding style issue and ...

In my opinion this code was already correct, and would display correctly
at any TAB setting. This patch changes it so that it displays
incorrectly
at all TAB settings other than 8.

Example:

Correct:
<tabs>function(arg1,
<tabs><9spaces>arg2

Incorrect:
<tabs>function(arg1,
<tabs>< tab  > arg2

For any TAB setting other than 8, arg1 and arg2 no longer line up.

Clive
