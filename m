Message-Id: <199912071307.OAA07349@appel.flower>
To: linuxppc-dev@lists.linuxppc.org
Subject: silly config problem with .30
Date: Tue, 07 Dec 1999 14:07:23 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



How do these kind of silly problems get in, without being noticed/fixed?
(No offence intended, I just wonder where to jump into this process)
Where to get latest kernels, if not from kernel.org or vger (I heard
ppc is dead, at vger?)

--- /usr/src/linux/arch/ppc/config.in.30	Tue Dec  7 13:47:09 1999
+++ /usr/src/linux/arch/ppc/config.in	Tue Dec  7 13:47:22 1999
@@ -85,9 +85,9 @@
 
 if [ "$CONFIG_APUS" = "y" ]; then
   define_bool CONFIG_PCI n
-else if [ "$CONFIG_OAK" = "y" ]; then
+elif [ "$CONFIG_OAK" = "y" ]; then
   define_bool CONFIG_PCI n
-else if [ "$CONFIG_8xx" = "y" ]; then
+elif [ "$CONFIG_8xx" = "y" ]; then
     bool 'QSpan PCI' CONFIG_PCI
 else
     define_bool CONFIG_PCI y


Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien/      | http://www.lilypond.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
