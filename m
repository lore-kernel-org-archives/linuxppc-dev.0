Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Mar 2008 16:21:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Trivial formatting fixes
Message-ID: <20080326052103.GB2090@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes some trivial indentation and brace/bracket style
problems.

---
 dtc.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-26 16:18:51.000000000 +1100
+++ dtc/dtc.c	2008-03-26 16:19:12.000000000 +1100
@@ -163,8 +163,8 @@
 			boot_cpuid_phys = strtol(optarg, NULL, 0);
 			break;
 		case 'v':
-		    printf("Version: %s\n", DTC_VERSION);
-		    exit(0);
+			printf("Version: %s\n", DTC_VERSION);
+			exit(0);
 		case 'h':
 		default:
 			usage();
@@ -179,9 +179,8 @@
 		arg = argv[optind];
 
 	/* minsize and padsize are mutually exclusive */
-	if ((minsize) && (padsize)) {
+	if (minsize && padsize)
 		die("Can't set both -p and -S\n");
-	}
 
 	fprintf(stderr, "DTC: %s->%s  on file \"%s\"\n",
 		inform, outform, arg);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
