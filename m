Date: Sun, 14 Sep 2003 21:40:38 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: [PATCH] incorrect extern declarations
Message-ID: <20030914194038.GA19676@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


both variables are declared static earlier in the file. gcc3.4 doesnt
tolerated the extern anymore.

--- linux-2.4.23-pre4/arch/ppc/platforms/prep_pci.c~	2003-08-25 13:44:40.000000000 +0200
+++ linux-2.4.23-pre4/arch/ppc/platforms/prep_pci.c	2003-09-14 17:36:54.000000000 +0200
@@ -1141,8 +1141,6 @@ void __init
 prep_pcibios_fixup(void)
 {
         struct pci_dev *dev;
-        extern unsigned char *Motherboard_map;
-        extern unsigned char *Motherboard_routes;

 	prep_route_pci_interrupts();

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
