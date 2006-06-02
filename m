Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa4.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 0418C67A6F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 01:07:40 +1000 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: 8xx spi completion sometime doesn't generate an interrupt
Date: Fri, 2 Jun 2006 17:08:48 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606021708.48814.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

As far I understood the spi bus device of mpc8xx works independently from the 
attached device (in my case a dataflash m25pe80). Thus I don't understand why 
sometime when I start an SPI transfer I don't receive an interrupt for the 
completion of this operation. I wait 50 ms for this interrupt and sometime it 
doesn't happen. Anyone had a similar problem?

Bye,
Antonio.
