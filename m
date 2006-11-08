Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id EFFF767CA8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 15:12:16 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 995A2467F0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 17:12:16 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 8858A467CF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Nov 2006 17:12:13 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8E004016AXBZ00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 08 Nov 2006 17:12:13 +1300 (NZDT)
Received: from [172.25.140.15] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0J8E002RM90D6810@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 08 Nov 2006 17:12:13 +1300 (NZDT)
Date: Wed, 08 Nov 2006 17:12:03 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Freescale combined ethernet driver
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <45515913.3080206@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

OK - I give up - whats the name of the device?

I've tried eth0, fsl-cpm-fec0 (and other combinations) with a 
commandline of the form:

   ip=172.25.206.113:172.25.140.15::255.255.0.0:unset:fsl-cpm-fec0:off \ 
panic=1 console=ttyCPM0

and I get the following errors:
[   37.249708] TCP bic registered
[   37.255389] Initializing IPsec netlink socket
[   37.264134] NET: Registered protocol family 1
[   37.272673] NET: Registered protocol family 17
[   37.281436] NET: Registered protocol family 15
[   37.796233] IP-Config: Device `fsl-cpm-fec0' not found.
[   37.807814] Looking up port of RPC 100003/2 on 172.25.140.15
[   37.819328] portmap: RPC call returned error 101

This is on an 859T CPU so its a CPM1 and I'm using the single SCC 
channel as a serial UART.

-- 
Robin

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
