Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A7C90DE67C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 23:44:05 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 1/2] [MTD] Add support for RAM & ROM mappings in the
	physmap_of MTD driver.
MIME-Version: 1.0
Date: Wed, 26 Mar 2008 13:44:03 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803261344.03438.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/mtd/maps/physmap_of.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/maps/physmap_of.c b/drivers/mtd/maps/physmap_of.c
index 49acd41..65c30b5 100644
=2D-- a/drivers/mtd/maps/physmap_of.c
+++ b/drivers/mtd/maps/physmap_of.c
@@ -273,6 +273,14 @@ static struct of_device_id of_flash_match[] =3D {
 		.data		=3D (void *)"jedec_probe",
 	},
 	{
+		.compatible	=3D "physmap-ram",
+		.data		=3D (void *)"map_ram",
+	},
+	{
+		.compatible	=3D "physmap-rom",
+		.data		=3D (void *)"map_rom",
+	},
+	{
 		.type		=3D "rom",
 		.compatible	=3D "direct-mapped"
 	},
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
