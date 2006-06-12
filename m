Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx4-1.spamtrap.magma.ca (mx4-1.spamtrap.magma.ca
	[209.217.78.176])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DDCD67B21
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Jun 2006 05:57:13 +1000 (EST)
Received: from mail2.magma.ca (mail2.internal.magma.ca [10.0.10.12])
	by mx4-1.spamtrap.magma.ca (8.13.1/8.13.1) with ESMTP id k5CJv96F005443
	for <linuxppc-embedded@ozlabs.org>; Mon, 12 Jun 2006 15:57:09 -0400
Received: from [192.9.200.213] ([64.26.174.130]) (authenticated bits=0)
	by mail2.magma.ca (Magma's Mail Server) with ESMTP id k5CJv6P9026142
	for <linuxppc-embedded@ozlabs.org>; Mon, 12 Jun 2006 15:57:08 -0400
Message-ID: <448DC718.1010700@ics-ltd.com>
Date: Mon, 12 Jun 2006 15:57:12 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: How to determine IRQ w/ PPC045 (Virtex II Pro)?
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

When writing device drivers for a 2.6 linux kernel running on a PPC405, 
in a Virtex II Pro, how do I determine which IRQ to use in my call to 
request_irq? I imagine that the IRQ will be directly dependent on how my 
device's interrupt is connected to the interrupt controller I'm using, 
but I don't know how to figure out the IRQ number. Any help would be 
appreciated.

Regards,
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
