Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 9C88E67A7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 13:56:43 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 6A5B410BA86
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 15:31:49 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id D873510BA85
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 15:31:48 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0IAW00901JVH4C00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 26 Jan 2005 15:31:48 +1300 (NZDT)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0IAW0062XKD0VI60@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 26 Jan 2005 15:31:48 +1300 (NZDT)
Date: Wed, 26 Jan 2005 15:31:48 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <41F70114.5040200@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: 8xx bus monitoring
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

Greetings

System is a MPC859 based controller.

I'm trying to determine whether a peripheral is not responding to memory 
fetches by using the bus monitor feature on the Transfer Acknowledge 
(TA) signal. This is set to the maximum count in the Bus Monitor Timeout 
(BMT) in the System Protect Control Register (SYPCR). The monitoring is 
enabled by setting the Bus Monitor Enable (BME) bit in SYPCR as well.

I understand that I can use the Transfer Error Status Register (TESR) to 
read the fact that I have had a timeout by checking the Data Transfer 
Monitor Timeout (DTMT) bit in this register.

The problem is, how do I know any error has occured so I know to look at 
  the TESR. I can't see a way of generating an exception from this 
condition.

Any help appreciated.

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

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
