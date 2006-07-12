Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6E0EE67B6C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 17:10:52 +1000 (EST)
Date: Wed, 12 Jul 2006 17:08:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 2/3] Update IBM virtual console entry in devices.txt
Message-Id: <20060712170854.2a1ecf4f.sfr@canb.auug.org.au>
In-Reply-To: <20060712170655.459b8d71.sfr@canb.auug.org.au>
References: <20060712170655.459b8d71.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, device@lanana.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Char major was never used for iSeries consoles in the mainline kernel.
It has been used for the pSeries virtual and RTAS consoles and will be
used for the new iSeries console.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/devices.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff --git a/Documentation/devices.txt b/Documentation/devices.txt
index 4aaf68f..c661dca 100644
--- a/Documentation/devices.txt
+++ b/Documentation/devices.txt
@@ -3005,9 +3005,9 @@ Your cooperation is appreciated.
 		  2 = /dev/3270/tub2		Second 3270 terminal
 		    ...
 
-229 char	IBM iSeries virtual console
-		  0 = /dev/iseries/vtty0	First console port
-		  1 = /dev/iseries/vtty1	Second console port
+229 char	IBM iSeries/pSeries virtual console
+		  0 = /dev/hvc0			First console port
+		  1 = /dev/hvc1			Second console port
 		    ...
 
 230 char	IBM iSeries virtual tape
-- 
1.4.0
