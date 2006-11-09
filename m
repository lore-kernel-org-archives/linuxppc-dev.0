Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id CB44567C3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 07:27:16 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 75E9C467DE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 09:27:16 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 6527E46757
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Nov 2006 09:27:16 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8H00F01CGBHC00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Fri, 10 Nov 2006 09:27:16 +1300 (NZDT)
Date: Fri, 10 Nov 2006 09:27:00 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: Freescale combined ethernet driver
In-reply-to: <20061109174947.415c7f7f@vitb.ru.mvista.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-id: <45538F14.5020205@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <45515913.3080206@tait.co.nz>
	<20061109174947.415c7f7f@vitb.ru.mvista.com>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
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

Vitaly Bordug wrote:

> I am not following why you're touching netdev name here... Your problem clearly points to the unregistered platform device (which should be added to the identification code that maps system to the platform device list). In short, bsp code does name matching of the supported boards, and ties it to the enum of platform devices aught to be registered for this board. It registers nothing by default, and since fs_enet fail to found anything suitable on platform bus, not network devices created.
> 
> Yet it may be not the case of course - too less information to be sure. 
> 
> Assuming it is not relevant to you anymore, just for archive purposes.
> 

Is there a howto that explains in simple terms (i.e. not "do like board 
X but I'm not going to tell which bits of the code are crap" but an 
actual interface spec) on how to create this (as far as I can see 
totally undocumented) platform device.

BTW: the code is NOT the documentation - that is the 'how' not the 'why'!


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
