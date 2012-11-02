Return-Path: <anton@samba.org>
Date: Fri, 2 Nov 2012 11:55:55 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@ozlabs.org,
 dhowells@redhat.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Remove stale function prototypes from setup.h
Message-ID: <20121102115555.601277dd@kryten>
In-Reply-To: <20121102115504.02c7fe4c@kryten>
References: <20121102115504.02c7fe4c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I noticed a couple of function prototypes for functions that
no longer exist. Remove them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/setup.h
===================================================================
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -13,10 +13,6 @@ extern unsigned long long memory_limit;
 extern unsigned long klimit;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
-extern void via_cuda_init(void);
-extern void read_rtc_time(void);
-extern void pmac_find_display(void);
-
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
 
