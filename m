Date: Fri, 30 Nov 2001 10:48:03 -0500
From: Kent Borg <kentborg@borg.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Typo in drivers/char/Config.in?
Message-ID: <20011130104803.C8845@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry about doing a send before I was through writing that last e-mail.

As I was saying, I think there is a typo in drivers/char/Config.in.


-kb



--- linuxppc_2_4_devel/drivers/char/Config.in	Thu Nov 29 11:07:32 2001
+++ linuxppc_2_4_devel/drivers/char/Config.in.fixed	Fri Nov 30 10:44:33 2001
@@ -191,7 +191,7 @@

 dep_tristate 'Intel i8x0 Random Number Generator support' CONFIG_INTEL_RNG $CONFIG_PCI
 tristate '/dev/nvram support' CONFIG_NVRAM
-if [ "$CONFIG_PPC_ISERIES" != "y"  -a "$CONFIG_PPC_PSERIES" != y ]; then
+if [ "$CONFIG_PPC_ISERIES" != "y"  -a "$CONFIG_PPC_PSERIES" != "y" ]; then
    tristate 'Enhanced Real Time Clock Support' CONFIG_RTC
 fi
 if [ "$CONFIG_IA64" = "y" ]; then

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
