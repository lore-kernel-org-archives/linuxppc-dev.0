Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8CE58DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 10:13:55 +1100 (EST)
Message-Id: <20090320222711.994532821@mini.kroah.org>
Date: Fri, 20 Mar 2009 15:26:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org,
 stable@kernel.org,
 greg@kroah.com
Subject: [patch 19/32] powerpc: Remove extra semicolon in fsl_soc.c
References: <20090320222611.872315885@mini.kroah.org>
In-Reply-To: <20090320231037.GA2732@kroah.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Johns Daniel <johns.daniel@gmail.com>, Eugene Teo <eteo@redhat.com>,
	Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>,
	Chris Wedgwood <reviews@ml.cw.f00f.org>,
	Jake Edge <jake@lwn.net>, linuxppc-dev@ozlabs.org,
	Randy Dunlap <rdunlap@xenotime.net>,
	Michael Krufky <mkrufky@linuxtv.org>, alan@lxorguk.ukuu.org.uk,
	Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>,
	Chuck Wolber <chuckw@quantumlinux.com>,
	akpm@linux-foundation.org, afleming@freescale.com,
	torvalds@linux-foundation.org, Willy Tarreau <w@1wt.eu>,
	Rodrigo Rubira Branco <rbranco@la.checkpoint.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2.6.27-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Johns Daniel <jdaniel@computer.org>

TSEC/MDIO will not work with older device trees because of a semicolon
at the end of a macro resulting in an empty for loop body.

This fix only applies to 2.6.28; this code is gone in 2.6.29, according
to Grant Likely!

Signed-off-by: Johns Daniel <johns.daniel@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 arch/powerpc/sysdev/fsl_soc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -255,7 +255,7 @@ static int __init gfar_mdio_of_init(void
 		gfar_mdio_of_init_one(np);
 
 	/* try the deprecated version */
-	for_each_compatible_node(np, "mdio", "gianfar");
+	for_each_compatible_node(np, "mdio", "gianfar")
 		gfar_mdio_of_init_one(np);
 
 	return 0;
