Return-Path: <t.denzinger@lesametric.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 7EBD6679E0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 03:18:12 +1100 (EST)
Message-Id: <13134516.38521165335487229.JavaMail.servlet@kundenserver>
From: Thomas Denzinger <t.denzinger@lesametric.de>
To: <linuxppc-embedded@ozlabs.org>
Subject: Speed of plb_temac 3.00 on ML403
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Dec 2006 17:18:07 +0100
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have to interface to a camera with the GigE Vision protocol.

For that I set up a design on ML403 with PPC, Temac and sgDMA. I use MontaVista 2.4.20 Linux with the BSP from Xilinx EDK 8.2. The camera vendor supplied a library for GigE Vision, which works under Linux.
The results of some tests showed that I have to insert waiting time between frames sent by the camera, otherwise the lib signals errors.
This leeds to only 1/10 of the needed transfer rate. 

My question is now: Has anybody deeper knowledge how ethernet and sgDMA works? How deep is the PPC involved in the data transfer? Or does the Temac-core handle the datatransfer to DDR-memory autonomous?

I learnd from the camera vendor, that on PCs with special Intel ethernet chips, it works outonomous and so the high transfer rate can be accomplished. 

I'm very interested to get in contact with people who have to interface with a GigE Vision camera.

Also interesting is if anybody benchmarked the gigabit ethernet on the ML403 hardware. How fast is the gigabit interface realy?

Thomas


-- 
Thomas Denzinger
LesaMetric GmbH 
Hauptstrasse 46
35649 Bischoffen

Tel.: 06444/931928
Fax : 06444/931912
