Return-Path: <liranrazlinux@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id BA1B1DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 03:00:24 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so10312ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 09 Dec 2008 08:00:22 -0800 (PST)
Message-ID: <e3b3ab5c0812090800m760e2ef8p5ee2f9120fb2fce4@mail.gmail.com>
Date: Tue, 9 Dec 2008 11:00:21 -0500
From: "liran raz" <liranrazlinux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: which irqflag to use with request_irq
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12274_20544587.1228838421825"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_12274_20544587.1228838421825
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,

When using the function:
int request_irq (unsigned int      irq,
     irq_handler_t      handler,
     unsigned long      irqflags,
     const char *      devname,
     void *      dev_id);

To connect an ISR to one of the processor's
peripherals irq (SCC in my case).

Which value I should use for irqflags,
from the list in: interrupt.h file.

Kernel 2.6.24
Processor: MPC8272

Thanks,
Liran.

------=_Part_12274_20544587.1228838421825
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br><br>When using the function:<br>int request_irq (unsigned int&nbsp; &nbsp;&nbsp;&nbsp; irq,<br>&nbsp;&nbsp;&nbsp;&nbsp; irq_handler_t&nbsp; &nbsp;&nbsp;&nbsp; handler,<br>&nbsp;&nbsp;&nbsp;&nbsp; unsigned long&nbsp; &nbsp;&nbsp;&nbsp; irqflags,<br>&nbsp;&nbsp;&nbsp;&nbsp; const char *&nbsp; &nbsp;&nbsp;&nbsp; devname,<br>&nbsp;&nbsp;&nbsp;&nbsp; void *&nbsp; &nbsp;&nbsp;&nbsp; dev_id);<br><br>
To connect an ISR to one of the processor&#39;s<br>peripherals irq (SCC in my case).<br><br>Which value I should use for irqflags,<br>from the list in: interrupt.h file.<br><br>Kernel 2.6.24<br>Processor: MPC8272<br><br>Thanks,<br>
Liran.<br><br><br>

------=_Part_12274_20544587.1228838421825--
