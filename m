Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id ADD322BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 15:15:13 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 730ED10BA2A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 17:15:12 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id E7E5410B96D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Dec 2004 17:15:11 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0I8D00L01VWUF500@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Wed, 08 Dec 2004 17:15:11 +1300 (NZDT)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0I8D00DEHYHB9E90@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Wed, 08 Dec 2004 17:15:11 +1300 (NZDT)
Date: Wed, 08 Dec 2004 17:15:11 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <41B67FCF.6040100@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: Exception handling on mpc8xx cores
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

Any Freescale lurkers out there?

The mpc866 manual implies that if the internal core times out an 
external Transfer Acknowledge bus signal (by exerting the internally 
generated Transfer Error Acknowledge signal) an exception is generated.

I've tried extending the external TA signal well beyond 2040 clock 
cycles the maximum timeout allows and I see the busses start up again 
(indicationg that they are no longer waiting) but I don't see anything 
on TEA and I don't get an exception thrown.

Any clues? Manual error?, silicon error?, my brain error?

Cheers

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
