Return-Path: <jpl@xiphos.ca>
Received: from mail.net (custpop.ca.mci.com [142.77.1.111])
	by ozlabs.org (Postfix) with ESMTP id 7D59567A2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 13:47:39 +1100 (EST)
Received: from [216.95.199.150] (account jpl@xiphos.ca HELO [192.168.1.169])
	by mail.net (CommuniGate Pro SMTP 4.2.8)
	with ESMTP id 41990560 for linuxppc-embedded@ozlabs.org;
	Thu, 03 Feb 2005 21:47:37 -0500
Message-ID: <4202E286.1010206@xiphos.ca>
Date: Fri, 04 Feb 2005 02:48:38 +0000
From: Joshua Lamorie <jpl@xiphos.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Edge Interrupts (Virtex-II Pro)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Gidday there,

Is there a cleaner way to specify that an interrupt is edge triggered 
other than directly accessing irq_desc_t irq_desc []?

In my module, when I request_irq, if it succeeds I do the following.

      irq_desc[iIRQ].status &= ~(IRQ_LEVEL);

Is there a better way?

Thanks in advance

Joshua

-- 

Xiphos Technologies
(514) 848-9640 x227
(514) 848-9644 fax

www.xiplink.com
_______________________________________________
The information transmitted is intended only for the
person or entity to which it is addressed and may contain
confidential and/or privileged material.  If you have
received this in error, please contact the sender and delete
this communication and any copy immediately. Thank you.
