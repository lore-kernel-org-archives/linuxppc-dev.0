Return-Path: <ilpo.jarvinen@helsinki.fi>
Date: Tue, 19 Aug 2008 08:48:57 +0300 (EEST)
From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
To: paulus@samba.org, benh@kernel.crashing.org,
  linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/spufs: Remove invalid semicolon after if statement
Message-ID: <Pine.LNX.4.64.0808190845570.4551@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-696208474-1696692584-1219124937=:4551"
Cc: Christian Krafft <krafft@de.ibm.com>, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-1696692584-1219124937=:4551
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---
 arch/powerpc/platforms/cell/spufs/sched.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 2deeeba..f7e5af8 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -1030,7 +1030,7 @@ void spuctx_switch_state(struct spu_context *ctx,
 		node = spu->node;
 		if (old_state == SPU_UTIL_USER)
 			atomic_dec(&cbe_spu_info[node].busy_spus);
-		if (new_state == SPU_UTIL_USER);
+		if (new_state == SPU_UTIL_USER)
 			atomic_inc(&cbe_spu_info[node].busy_spus);
 	}
 }
-- 
1.5.2.2

---696208474-1696692584-1219124937=:4551--
