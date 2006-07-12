Return-Path: <brijesh.chodavadiya@einfochips.com>
Received: from india.einfochips.com (india.einfochips.com [203.88.139.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "india.einfochips.com",
	Issuer "india.einfochips.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 95F98679FB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 16:55:09 +1000 (EST)
Message-ID: <44B49AEE.5010407@einfochips.com>
Date: Wed, 12 Jul 2006 12:17:10 +0530
From: "brijesh.chodavadiya@einfochips.com" <brijesh.chodavadiya@einfochips.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: request_irq in a module casues kernel crash
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

please rewrite handler function with,

 void handler(int irq, void *dev_id, struct pt_regs * regs)
 {
	printk("Interrupt handler invoked for irq %d \n",irq);
	return IRQ_HANDLED;
 }



eInfochips Business Disclaimer:
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by eInfochips Limited and/or eInfochips Inc("eInfochips") unless sent with that express intent and with due authority of eInfochips. eInfochips has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
