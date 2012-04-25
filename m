Return-Path: <geoff@infradead.org>
Message-Id: <08a6b25631b5f1984a963fd7cf9771898ebb07e5.1335379330.git.geoff@infradead.org>
In-Reply-To: <cover.1335379330.git.geoff@infradead.org>
References: <cover.1335379330.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 01/10] powerpc/ps3: Correct lv1 repository routine names
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 Apr 2012 19:19:34 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Nathan Whitehorn <nwhitehorn@freebsd.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename these repo routines:

  modify_repository_node_value => write_repository_node
  remove_repository_node => delete_repository_node

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/include/asm/lv1call.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/lv1call.h b/arch/powerpc/include/asm/lv1call.h
index 233f9ec..f511767 100644
--- a/arch/powerpc/include/asm/lv1call.h
+++ b/arch/powerpc/include/asm/lv1call.h
@@ -265,8 +265,8 @@ LV1_CALL(get_spe_irq_outlet,                            2, 1,  78 )
 LV1_CALL(set_spe_privilege_state_area_1_register,       3, 0,  79 )
 LV1_CALL(create_repository_node,                        6, 0,  90 )
 LV1_CALL(read_repository_node,                          5, 2,  91 )
-LV1_CALL(modify_repository_node_value,                  6, 0,  92 )
-LV1_CALL(remove_repository_node,                        4, 0,  93 )
+LV1_CALL(write_repository_node,                         6, 0,  92 )
+LV1_CALL(delete_repository_node,                        4, 0,  93 )
 LV1_CALL(read_htab_entries,                             2, 5,  95 )
 LV1_CALL(set_dabr,                                      2, 0,  96 )
 LV1_CALL(get_total_execution_time,                      2, 1, 103 )
-- 
1.7.9.5
