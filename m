Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 62435DDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 19:16:00 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1INmJW-0005G0-HS
	for linuxppc-embedded@ozlabs.org; Wed, 22 Aug 2007 11:15:46 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: C67x00 Driver IRQ Problem.
References: <939D37AEB47F1F49B88FAB6599B6023501A17279@hsv1dafpew02.das.gov.sanm.corp>
Date: Wed, 22 Aug 2007 11:15:46 +0200
In-Reply-To: <939D37AEB47F1F49B88FAB6599B6023501A17279@hsv1dafpew02.das.gov.sanm.corp>
	(Joseph M. Robertson's message of "Tue, 21 Aug 2007 13:57:19 -0500")
Message-ID: <874pisrku5.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "RJM" == Robertson, Joseph M <joseph.robertson@sanmina-sci.com> writes:

Hi,

RJM> c67x00 c67x00.0: USB OTG controller, p:0x43e00000, v:0xc5058000, irq:3
RJM> irq 3: nobody cared (try booting with the "irqpoll" option)

So most likely c67x00_hpi_status doesn't return != 0. Could you add a
printk to c67x00_irq to check?

-- 
Bye, Peter Korsgaard
