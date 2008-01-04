Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12A9BDDE36
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 08:11:05 +1100 (EST)
Date: Fri, 4 Jan 2008 15:10:47 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [PATCH 3/3] Remove \n from yyerror() call.
Message-ID: <20080104211047.GC28991@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The \n is provided by yyerror().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-parser.y |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index f50f2f0..3a24d14 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -332,7 +332,7 @@ subnodes:
 		}
 	| subnode propdef
 		{
-			yyerror("syntax error: properties must precede subnodes\n");
+			yyerror("syntax error: properties must precede subnodes");
 			YYERROR;
 		}
 	;
-- 
1.5.3
