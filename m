Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx1.magma.ca (mx1-4.spamtrap.magma.ca [209.217.78.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B378067A3A
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 05:29:51 +1000 (EST)
Received: from mail2.magma.ca (mail2.internal.magma.ca [10.0.10.12])
	by mx1.magma.ca (8.13.1/8.13.1) with ESMTP id k51JTYhb012764
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Jun 2006 15:29:35 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail2.magma.ca (Magma's Mail Server) with ESMTP id k51JTX9a005964
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Jun 2006 15:29:34 -0400
Message-ID: <447F4021.5030109@ics-ltd.com>
Date: Thu, 01 Jun 2006 15:29:37 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Pinned TLB entries with 2.6 linux kernel on PPC4xx
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

Does the idea of creating pinned TLB entries (ones that will never be 
overwritten) make sense for a PPC4xx (specifically PPC405) 2.6 linux 
kernel? If so, how would this be accomplished?

Regards,
Chris
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
