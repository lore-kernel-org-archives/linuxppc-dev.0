Return-Path: <ee04d004@ee.iitm.ac.in>
Received: from volt.ee.iitm.ac.in (unknown [203.199.213.53])
	by ozlabs.org (Postfix) with ESMTP id 1C3F968882
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 21:43:15 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by volt.ee.iitm.ac.in (Postfix) with ESMTP id 87528AF196
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 15:44:37 +0530 (IST)
Received: from volt.ee.iitm.ac.in ([127.0.0.1])
	by localhost (volt.ee.iitm.ac.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19285-01 for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 15:44:37 +0530 (IST)
Received: from mail-rly.ee.iitm.ac.in (localhost.localdomain [127.0.0.1])
	by volt.ee.iitm.ac.in (Postfix) with ESMTP id DC2E6AF0F0
	for <linuxppc-embedded@ozlabs.org.>;
	Thu, 15 Dec 2005 15:44:36 +0530 (IST)
From: "Leena Vachhani" <ee04d004@ee.iitm.ac.in>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 15 Dec 2005 15:44:36 +0530
Message-Id: <20051215100714.M19322@mail-rly.ee.iitm.ac.in>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: USB webcam driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to compile USB webcam driver (which works fine with RH 9.0 linux
2.4.20-8 kernel) with montavista linux for IBM PPC405 architecture. The header
file asm/current.h is giving error as "Invalid register name for 'current'".
Header file current.h has only one statement :

register struct task_struct *current asm ("r2");

I don't have any clue what is the problem in this statement. Please help me out.

Thanks
Leena Vachhani
