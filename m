Return-Path: <mgreer@mvista.com>
Date: Wed, 14 Nov 2007 12:04:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: prpmc2800 - Enable L2 cache
Message-ID: <20071114190402.GA28740@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Turn on the L2 cache on the prpmc2800 platform.

Signed-off-by: Mark A. Greer <mgreer@mvista.com

---
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index e484cac..653a5eb 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -144,6 +144,7 @@ static int __init prpmc2800_probe(void)
 		strncpy(prpmc2800_platform_name, m,
 			min((int)len, PLATFORM_NAME_MAX - 1));
 
+	_set_L2CR(_get_L2CR() | L2CR_L2E);
 	return 1;
 }
 
