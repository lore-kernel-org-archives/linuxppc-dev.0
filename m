Date: Fri, 12 Sep 2003 17:32:46 -0500
Mime-Version: 1.0 (Apple Message framework v552)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: combine PPC "general setup" and "platform setup"?
From: Hollis Blanchard <hollisb@us.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Message-Id: <08392963-E571-11D7-AC00-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In 2.5's menuconfig there are now two "general setup" sections; one is
generic and one is ours. We also have a "platform setup" section. It
seems like all our "general setup" questions could be folded into
"platform setup", e.g. "Workarounds for PPC601 bugs" and "Support for
Open Firmware device tree in /proc". Can we get rid of our "general
setup"?

--- 1.36/arch/ppc/Kconfig       Wed Sep  3 07:16:34 2003
+++ edited/arch/ppc/Kconfig     Fri Sep 12 17:30:53 2003
@@ -739,10 +739,6 @@
           this currently includes some models of iBook & Titanium
           PowerBook.

-endmenu
-
-menu "General setup"
-
  config HIGHMEM
         bool "High memory support"

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
