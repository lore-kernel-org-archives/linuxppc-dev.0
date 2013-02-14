Return-Path: <geoff@infradead.org>
Message-Id: <cf8f609bb785e9eebd9f9a3a22888440194afe12.1360810584.git.geoff@infradead.org>
In-Reply-To: <cover.1360810584.git.geoff@infradead.org>
References: <cover.1360810584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/4] powerpc/ps3: Add macro PS3_VERBOSE_RESULT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 14 Feb 2013 03:03:16 +0000
Cc: Geoff Levand <geoff@infradead.org>, cbe-oss-dev@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To allow more control of the verbosity of ps3_result() add a check
for the preprocessor macro PS3_VERBOSE_RESULT that builds a verbose
verion of the ps3_result() routine.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/include/asm/ps3.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index 0e15db4..678a7c1 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -245,7 +245,7 @@ enum lv1_result {
 
 static inline const char* ps3_result(int result)
 {
-#if defined(DEBUG)
+#if defined(DEBUG) || defined(PS3_VERBOSE_RESULT)
 	switch (result) {
 	case LV1_SUCCESS:
 		return "LV1_SUCCESS (0)";
-- 
1.7.9.5
