Date: Sat, 22 Mar 2003 22:56:48 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
Subject: Re: ppc: Makefile tidy-up round 2
Message-ID: <20030322215648.GD15911@mars.ravnborg.org>
References: <20030320222759.GA12267@mars.ravnborg.org> <20030322215403.GA15911@mars.ravnborg.org> <20030322215552.GB15911@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030322215552.GB15911@mars.ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.874   -> 1.875
#	arch/ppc/boot/simple/Makefile	1.35    -> 1.36
#	arch/ppc/boot/common/dummy.c	1.2     ->         (deleted)
#	               (new)	        -> 1.1     arch/ppc/boot/simple/dummy.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	sam@mars.ravnborg.org	1.875
# ppc: boot/common/dummy.c deleted
# --------------------------------------------
#
diff -Nru a/arch/ppc/boot/common/dummy.c b/arch/ppc/boot/common/dummy.c
--- a/arch/ppc/boot/common/dummy.c	Sat Mar 22 22:47:19 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,4 +0,0 @@
-int main(void)
-{
-	return 0;
-}
diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	Sat Mar 22 22:47:19 2003
+++ b/arch/ppc/boot/simple/Makefile	Sat Mar 22 22:47:19 2003
@@ -160,8 +160,7 @@
 MKPREP				:= $(utils)/mkprep
 MKTREE				:= $(utils)/mktree

-$(obj)/dummy.o: $(common)/dummy.c
-	$(CC) -c -o $@ $(common)/dummy.c
+targets := dummy.o

 $(obj)/zvmlinux: $(OBJS) $(LIBS) $(boot)/ld.script $(images)/vmlinux.gz \
 		$(obj)/dummy.o
diff -Nru a/arch/ppc/boot/simple/dummy.c b/arch/ppc/boot/simple/dummy.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/boot/simple/dummy.c	Sat Mar 22 22:47:19 2003
@@ -0,0 +1,4 @@
+int main(void)
+{
+	return 0;
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
