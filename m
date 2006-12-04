Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id B857067BAB
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 15:53:54 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev@ozlabs.org
Subject: [LIBFDT] Add cscope target to Makefile
Date: Sun,  3 Dec 2006 21:53:41 -0700
Message-Id: <116520802113-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d464a82..0c3b143 100644
--- a/Makefile
+++ b/Makefile
@@ -55,6 +55,9 @@ stress:	all
 stressv: all
 	cd tests; ./run_tests.sh -t stress -v
 
+cscope:
+	cscope -b -k *.[ch] tests/*.[ch]
+
 %.o: %.c
 	@$(VECHO) CC $@
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ -c $<
@@ -73,7 +76,7 @@ libfdt.a: $(LIBOBJS)
 
 clean:
 	@$(VECHO) CLEAN
-	rm -f *~ *.o *.so *.a *.d *.i *.s core a.out $(VERSION)
+	rm -f *~ *.o *.so *.a *.d *.i *.s core a.out cscope.out $(VERSION)
 	$(MAKE) -C tests clean
 
 %.d: %.c
-- 
1.4.3.rc2.g0503
