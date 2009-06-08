Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1D0BB70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 16:15:21 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 5115CDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2009 16:15:21 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MDY8b-0007sN-5g
	for linuxppc-dev@ozlabs.org; Sun, 07 Jun 2009 23:15:17 -0700
Message-ID: <23918722.post@talk.nabble.com>
Date: Sun, 7 Jun 2009 23:15:17 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: what is /proc/interrupts & /proc/irq/*/spurious mean?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi All,
i have a board shipped with Linux kernel 2.6.27.

i have some problems in interrupts but while i was gathering some info about
the interrupts on my board by


cat /proc/interrupts
           CPU0
 16:       2525   OpenPIC   Level     enet_tx
 17:       5606   OpenPIC   Level     enet_rx
 18:          0   OpenPIC   Level     enet_error
 21:          3   OpenPIC   Level     fsldma-channel
 22:          3   OpenPIC   Level     fsldma-channel
 23:          3   OpenPIC   Level     fsldma-channel
 25:          3   OpenPIC   Level     fsldma-channel
 26:        461   OpenPIC   Level     serial
 27:          0   OpenPIC   Level     i2c-mpc
 48:          4   OpenPIC   Level     phy_interrupt
 50:          0   OpenPIC   Edge      DSP-A
 52:         11   OpenPIC   Edge      DSP-B
 54:          0   OpenPIC   Level     FPGA
BAD:          0

actually i m interested in IRQ number 52.
from the previous command: it seems to me OpenPIC has received 11 interrupt
from the device namely DSP-B& this interrupt is edge triggered. Is it
correct?

Also i use:


cat /proc/irq/52/spurious
count 11
unhandled 0
last_unhandled 0 ms

but actually i dont understan its meaning?
does it mean that i received 11 spurious interrupt? i expect this because
the name of the file is spurious.

what does the field unhandled mean?

thanks for ur help.
-- 
View this message in context: http://www.nabble.com/what-is--proc-interrupts----proc-irq-*-spurious-mean--tp23918722p23918722.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
