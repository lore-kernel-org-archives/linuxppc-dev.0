Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 71C80DE29D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 18:49:30 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1K4B9z-0008R9-Bo
	for linuxppc-embedded@ozlabs.org; Thu, 05 Jun 2008 01:49:27 -0700
Message-ID: <17665078.post@talk.nabble.com>
Date: Thu, 5 Jun 2008 01:49:27 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Concern regarding Booting up of linux board ...
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ..

we are using IMX-31 (ARM Core) processor with Linux 2.6 and redboot as boot
loader with jffs2 for NAND flash and facing the concerned problem :-

The board is booting fine but it sometimes takes 21 sec to boot and
sometimes takes 31 sec to boot which is a concern for us actually it takes
usually 21 sec and 31 sec sometimes 

If we remove the power after booting and again insert the power supply It
gives the following warning message related to jffs2 ....

JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x011dec00: read 0x2464ba56, calculated 0x474915f8.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x0112be00: read 0x149efa32, calculated 0x8f32b0eb.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x0112ba00: read 0xdcfafeb2, calculated 0xb86eb888.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x013e8600: read 0x20bed1fc, calculated 0xe9509808.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x013e9200: read 0x6e4f40bd, calculated 0x28248aa4.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x013e8e00: read 0x6e4f40bd, calculated 0x59eaeede.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x011df000: read 0x6e4f40bd, calculated 0xbf916037.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x011dde00: read 0x6e4f40bd, calculated 0x946d0599.
JFFS2 notice: (878) check_node_data: wrong data CRC in data node at
0x011dc800: read 0x6e4f40bd, calculated 0x1e890eaa.
JFFS2 notice: (759) check_node_data: wrong data CRC in data node at
0x008c0200: read 0xd3ad877b, calculated 0xf4f0b5f9.
JFFS2 notice: (759) check_node_data: wrong data CRC in data node at
0x0097b800: read 0x8d0623a1, calculated 0xefce6ce7.
JFFS2 notice: (759) check_node_data: wrong data CRC in data node at
0x00965200: read 0x8d0623a1, calculated 0x92a2a227.

Having never experienced this before i do believe that this could be the
jffs2 related concern hence just thinking of using YAFFS to increase the
booting effeciency ...


I would remain thankful if any of you could share your experience or thaught
regarding this ...

Thank you 
Misbah <><
-- 
View this message in context: http://www.nabble.com/Concern-regarding-Booting-up-of-linux-board-...-tp17665078p17665078.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
