Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7E062DDEC1
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 06:08:20 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 29 Feb 2008 20:08:17 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20080229190817.81180@gmx.net>
MIME-Version: 1.0
Subject: No serial port interrupts in /proc/interrupts
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm wondering why the serial port interrupts don't show up in
/proc/interrupts or in debugfs/powerpc/virq_mapping. I added some debugging
code to the relevant code in arch/powerpc/kernel/irq.c and of_serial.c and
it looks like irq_of_parse_and_map() returns valid virqs (irq3, irq4 on a
i8259) for the two ns16550 compatible UARTs. Is there anything else to do,
to correctly implement UART support for a platform?

regards,

Gerhard

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
