Date: Tue, 27 Jul 2004 12:42:17 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: [PATCH] move 8xx microcode patches into Kconfig submenu
Message-ID: <Pine.LNX.4.60.0407271240530.6062@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   create a submenu for 8xx microcode patches to keep them organized in
one place, under the assumption that there will be more to come.

--- linuxppc-2.5/arch/ppc/8xx_io/Kconfig 2004-07-27 12:36:24.050604776 -0400
+++ linuxppc-2.5.new/arch/ppc/8xx_io/Kconfig 2004-07-27 12:36:56.869615528 -0400
@@ -140,6 +140,8 @@

  	  If in doubt, say N here.

+menu "Microcode patches"
+
  config UCODE_PATCH
  	bool "I2C/SPI Microcode Patch"
  	help
@@ -150,3 +152,5 @@

  endmenu

+endmenu
+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
