Return-Path: <mike@compulab.co.il>
Received: from alex (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id D3E7B67A65
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Mar 2005 19:47:50 +1000 (EST)
Message-ID: <42467D8A.8050606@compulab.co.il>
Date: Sun, 27 Mar 2005 11:31:54 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Problem running Linux 2.6.11 on MPC8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I'm trying to bring up the Linux 2.6.11 on MPC8272ADS and it seem to 
hang up at the very beginning.
I use ads8272_defconfig and then enable console on SCC:

CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
CONFIG_SERIAL_CPM_SCC1=y


when I boot the kernel from the u-boot the system hangs up right after 
the kernel decompression.

-- 
Sincerely Yours,
Mike Rapoport
-----------------------------------------------------------------
CompuLab Ltd.
MALAT Bldg., Technion, Haifa, ISRAEL
Mailing address: P.O. Box 66, Nesher 36770, ISRAEL
Tel: 972-4-8290146
Fax: 972-4-8325251
Web: http://www.compulab.co.il
