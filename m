Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0ks7c030026@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:24 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [patch 13/43] Add MAINTAINER entry for the new PowerPC 4xx on-chip
	ethernet controller driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Eugene Surovegin <ebs@ebshome.net>

Add MAINTAINER entry for the new PPC4xx EMAC driver

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN MAINTAINERS~add-maintainer-entry-for-the-new-powerpc-4xx-on-chip-ethernet-controller-driver MAINTAINERS
--- devel/MAINTAINERS~add-maintainer-entry-for-the-new-powerpc-4xx-on-chip-ethernet-controller-driver	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/MAINTAINERS	2005-10-28 17:44:03.000000000 -0700
@@ -1951,6 +1951,14 @@ M:	george@mvista.com
 L:	netdev@vger.kernel.org
 S:	Supported
 
+POWERPC 4xx EMAC DRIVER
+P:	Eugene Surovegin
+M:	ebs@ebshome.net
+W:	http://kernel.ebshome.net/emac/
+L:	linuxppc-embedded@ozlabs.org
+L:	netdev@vger.kernel.org
+S:	Maintained
+
 PNP SUPPORT
 P:	Adam Belay
 M:	ambx1@neo.rr.com
_
