Return-Path: <monstr@seznam.cz>
Received: from smtp01.pevnalinka.cz (smtp01.pevnalinka.cz [89.31.40.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D506DDE42
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 07:03:35 +1000 (EST)
Received: from monstrone (206-47-31-89.wifiinternet.cz [89.31.47.206] (may be
	forged))
	by smtp01.pevnalinka.cz (8.13.8/8.13.1) with SMTP id l8NIersD081317
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Sep 2007 18:40:55 GMT
	(envelope-from monstr@seznam.cz)
Message-ID: <01fc01c7fe11$5ef78f50$0200a8c0@monstrone>
From: "Michal Simek" <monstr@seznam.cz>
To: "linuxppc-dev" <linuxppc-dev@ozlabs.org>
Subject: FDT for Microblaze and PPC405
Date: Sun, 23 Sep 2007 20:40:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
Reply-To: Michal Simek <monstr@seznam.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
I made EDK tcl script for generation DTS test scructure for FDT. Script
support Microblaze and PowerPC 405.
Script was primary built for generation U-BOOT configs files for Microblaze.
For Microblaze can you generate both files (FDT and U-BOOT).
For PowerPC can you generate only DTS file. Generation U-BOOT configs files
aren't supported yet. Script ends after generation DTS.
Script has 2.00.a mark.
It is available at www.monstr.eu.

Cheers,
Michal Simek
