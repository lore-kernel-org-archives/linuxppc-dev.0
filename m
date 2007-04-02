Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id A84DFDDEFC
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2007 19:06:35 +1000 (EST)
Received: from ubuntu (achn-4db49c99.pool.einsundeins.de [77.180.156.153])
	by post.webmailer.de (fruni mo3) (RZmta 5.5)
	with ESMTP id N00f00j324ElS7 for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Apr 2007 11:06:31 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] ppc: Add support for AMCC 440SPe Katmai board
Date: Mon, 2 Apr 2007 11:07:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704021107.46790.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches adds support for the AMCC Katmai evaluation board
based on the 440SPe. It's still arch/ppc, so likely no chance of merging
upstream. Mainly for completeness. When the 4xx support in arch/powerpc
has stabilized a little we will try to move this support to arch/powerpc
too.

Best regards,
Stefan
