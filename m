Return-Path: <crichton@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by ozlabs.org (Postfix) with ESMTP id 02557B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 12:40:12 +1000 (EST)
Received: by qwk3 with SMTP id 3so56229qwk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Jul 2010 19:40:10 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 22 Jul 2010 22:40:10 -0400
Message-ID: <AANLkTikC9yTsg1vQSl__0s-CKTWs8NoM-UcmoDRvDwqz@mail.gmail.com>
Subject: [PATCH 1/1] Added PowerMac10,2 device descriptor
From: Mark Crichton <crichton@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Small patch to recognize the Mac Mini's that were quietly rolled out
~2005. Work needs to
be done on the WOL (Radeon and network card).

Signed-off-by: Mark Crichton <crichton@gmail.com>
---
 arch/powerpc/platforms/powermac/feature.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/feature.c
b/arch/powerpc/platforms/powermac/feature.c
index 9e1b9fd..fa90384 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2191,6 +2191,10 @@ static struct pmac_mb_def pmac_mb_defs[] = {
                PMAC_TYPE_UNKNOWN_INTREPID,     intrepid_features,
                PMAC_MB_MAY_SLEEP,
        },
+       {       "PowerMac10,2",                 "Mac mini (Late 2005)",
+               PMAC_TYPE_UNKNOWN_INTREPID,     intrepid_features,
+               PMAC_MB_MAY_SLEEP,
+       },
        {       "iMac,1",                       "iMac (first generation)",
                PMAC_TYPE_ORIG_IMAC,            paddington_features,
                0
-- 
1.7.1
