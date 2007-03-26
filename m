Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 7C9EEDDE3A
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Mar 2007 17:12:26 +1000 (EST)
Received: from ubuntu (achn-4db4987d.pool.einsundeins.de [77.180.152.125])
	by post.webmailer.de (fruni mo11) (RZmta 5.4)
	with ESMTP id 805696j2Q65DeW for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Mar 2007 09:12:24 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] ppc: Add support for AMCC 440EPx and 440GRx PPC's
Date: Mon, 26 Mar 2007 09:12:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200703260912.57443.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches adds support to the AMCC 440EPx and 440GRx PPC's and 
the evaluation boards Sequoia and Rainier. It's still arch/ppc, so likely no 
chance of merging upstream. Mainly for completeness. When the 4xx support in 
arch/powerpc has stabilized a little we will try to move this support to 
arch/powerpc too.

Best regards,
Stefan
