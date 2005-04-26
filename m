Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (tel096021.tait.co.nz [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id F1A6567B26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 12:57:36 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id F340A10BEE1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 14:57:35 +1200 (NZST)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 6D09310BEE0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 14:57:35 +1200 (NZST)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0IFJ00B0179EXB00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Tue, 26 Apr 2005 14:57:35 +1200 (NZST)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0IFJ002949JZ42A0@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Tue, 26 Apr 2005 14:57:35 +1200 (NZST)
Date: Tue, 26 Apr 2005 14:57:35 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <426DAE1F.7000404@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: 8xx SMC break handling
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

Greeting

Can anyone tell me if the break handling of an async SMC port will 
report a break immediately or whether it only reports it on the receipt 
of a valid character (which is what I'm seeing at present). As usual the 
  UM is a bit dry in this area!!

Maybe I've not enabled all that I need to in the SMC setup (based on 
2.4.22 Denx kernel UART driver).

Thanks...

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
