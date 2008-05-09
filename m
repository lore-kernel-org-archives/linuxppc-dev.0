Return-Path: <ndroogh@rogers.com>
Received: from web88102.mail.re2.yahoo.com (web88102.mail.re2.yahoo.com
	[206.190.37.203]) by ozlabs.org (Postfix) with SMTP id EF457DDF49
	for <linuxppc-dev@ozlabs.org>; Sat, 10 May 2008 04:56:24 +1000 (EST)
Date: Fri, 9 May 2008 14:49:04 -0400 (EDT)
From: Nick <ndroogh@rogers.com>
Subject: MPC5200b external interrupt registration problem
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <169407.5661.qm@web88102.mail.re2.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am writing a driver to service an interrupt from our fpga.  I am calling request_irq in the open
function of my driver.  The fpga is connected to external interrupt 1.  I am using interrupt
number 65 in the request_irq but the function is failing.  I traced to a function called setup_irq
in file /kernel/irq/manage.c.  It fails because at this line: if (desc->chip == &no_irq_chip) . 
Is 65 the wrong interrupt number?  What do I need to do to properly setup for external interrupts?

Thanks for any help,

Nick
