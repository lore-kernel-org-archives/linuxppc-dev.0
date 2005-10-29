Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lSZ2030129@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:57 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 42/43] ppc64: remove duplicate local variable in
	set_preferred_console
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

remove duplicate local variable, saves 2 asm instructions.

Signed-off-by: Olaf Hering <olh@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/kernel/setup.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN arch/ppc64/kernel/setup.c~ppc64-remove-duplicate-local-variable-in-set_preferred_console arch/ppc64/kernel/setup.c
--- devel/arch/ppc64/kernel/setup.c~ppc64-remove-duplicate-local-variable-in-set_preferred_console	2005-10-28 17:44:05.000000000 -0700
+++ devel-akpm/arch/ppc64/kernel/setup.c	2005-10-28 17:44:05.000000000 -0700
@@ -881,7 +881,6 @@ static int __init set_preferred_console(
 
  		if (reg && compat && (strcmp(compat, "hvterm-protocol") == 0)) {
  			/* Host Virtual Serial Interface */
- 			int offset;
  			switch (reg[0]) {
  				case 0x30000000:
  					offset = 0;
_
