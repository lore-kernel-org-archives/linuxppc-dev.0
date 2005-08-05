Return-Path: <roffermanns@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 9BBAD67DFE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 18:55:46 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id E61CDFB876
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 10:55:42 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id D4F30FB876
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 10:55:42 +0200 (CEST)
Received: from kolab.sysgo.com (rof.sysgo.com [172.22.10.10])
	by donald.sysgo.com (Postfix) with ESMTP id 4D95617DA7F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 11:34:42 +0200 (CEST)
From: Rolf Offermanns <roffermanns@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 5 Aug 2005 10:55:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200508051055.42264.roffermanns@sysgo.com>
Subject: PPC440EP (Bamboo) USB freeze - BDI2000 question
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
I have some problems with a 2.6.12 + Wades patches from 27.07. and John's usb 
host patch from 27.07.

I tried different external USB harddisks and card readers and the system 
freezes almost every time when doing some transfers (dd if=/dev/zero 
of=/dev/scsi/.../disc). Not immediately but after a minute or so.

I attached a BDI2000 (FW 1.14, configs from Denks FTP and the ones that came 
with the FW) but I am not able to bring the target to debug mode after the 
freeze. This is what I get:
-------------------------------------------------------------------------
440EP>halt
    Core number       : 0
    Core state        : running
# PPC: timeout while waiting for freeze
------------------------------------------------------------------------
440EP>stop
    Core number       : 0
    Core state        : running
# PPC: timeout while waiting for freeze
-------------------------------------------------------------------------

Strange thing: The freezes are getting less frequent the longer the target is 
running and when the BDI is attached it seems to be more difficult to hit the 
bug.

Any help is greatly appreciated.

Thanks,
Rolf

-- 
Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com
