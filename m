Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx5.magma.ca (mx5-1.spamtrap.magma.ca [209.217.78.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDDB367A77
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 07:13:30 +1000 (EST)
Received: from mail1.magma.ca ([10.0.10.11])
	by mx5.magma.ca (8.13.1/8.13.1) with ESMTP id k49LDIeL011219
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 May 2006 17:13:18 -0400
Received: from [192.9.200.156] ([64.26.174.130]) (authenticated bits=0)
	by mail1.magma.ca (Magma's Mail Server) with ESMTP id k49LDFV1011627
	for <linuxppc-embedded@ozlabs.org>; Tue, 9 May 2006 17:13:18 -0400
Message-ID: <446105F0.6080004@ics-ltd.com>
Date: Tue, 09 May 2006 17:13:20 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: When is it safe to start using ioremap?
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

At what point in the linux boot sequence can/should you start using 
ioremap to get a virtual address to hardware? Early on (in head_4xx.S), 
I'm setting up a TLB entry to access my hardware, but eventually my TLB 
entry will be overwritten, and at this point I would like to call 
ioremap to get an address for accessing my hardware. I'm having trouble 
figuring out when the original TLB entry will be overwritten (can that 
even be determined?), and at what point I can start calling ioremap.

Any help is appreciated.

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
