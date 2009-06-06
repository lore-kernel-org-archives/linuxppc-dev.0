Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D4AFB7096
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 23:17:48 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0F1B4DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 23:17:47 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MCvmI-0000VU-9F
	for linuxppc-dev@ozlabs.org; Sat, 06 Jun 2009 06:17:42 -0700
Message-ID: <23901807.post@talk.nabble.com>
Date: Sat, 6 Jun 2009 06:17:42 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Missing some interrupts
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
i have a freescale board, that contains MPC8555 processor & DSP-core
there is a GPIO connecting the DSP-core into an input pin of the OpenPIC of
the MPC8555 processor.

i test one interrupt from the DSP-core to the MPC8555 processor where i
configure this interrupt line to be edge-triggered (falling edge) & i
receive it successfully 
but 
when i generate this interrupt 10 successive times using for loop
i just receive 2 interrupts?

why can't i receive the 8 other interrupts?
i print the value of every irq number inside do_IRQ & i found that i receive
the DSP-interrupt just only twice.

do u have any suggestions to solve this problem?
i want to make sure that i can receive 10 interrupts
-- 
View this message in context: http://www.nabble.com/Missing-some-interrupts-tp23901807p23901807.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
