Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx3-2.spamtrap.magma.ca (mx3-2.spamtrap.magma.ca
	[209.217.78.169])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81EFA67C01
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Jun 2006 03:20:10 +1000 (EST)
Received: from mail2.magma.ca (mail2.internal.magma.ca [10.0.10.12])
	by mx3-2.spamtrap.magma.ca (8.13.0/8.13.1) with ESMTP id k58HJsTi019258
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 13:19:54 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail2.magma.ca (Magma's Mail Server) with ESMTP id k58HJqON009000
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 13:19:53 -0400
Message-ID: <44885C45.7020009@ics-ltd.com>
Date: Thu, 08 Jun 2006 13:20:05 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: VFS: Cannot open root device ...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to port a 2.6 kernel to a V2Pro-based board that I've got. I 
get the following output when trying to boot:

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
VFS: Cannot open root device "<NULL>" or unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)

I'm trying to use an initrd RAMDISK, and I've made sure that RAMDISK and 
initrd support are both enabled in the kernel configuration. Any ideas 
would be appreciated.

Cheers,
Chris Dumoulin
-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
