Message-ID: <67505026E29DD311A9AA00508B7315F30D4385@EXCHANGE>
From: Mike Flynn <mflynn@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: 860T interrupts in serial.c
Date: Mon, 13 Mar 2000 10:05:54 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



We are attempting to add a quad UART, a TI TL16C554FN, to our mother board
which hosts an Embedded Planet 860T-based CLLF and our video
encoder/decoder. Dan Malek wrote EP's uart.c which supports the SMCs/SCCs on
the 860T. We are looking at serial.c which was intended to support Intel
platforms. We prefer to use edge-triggered interrupts, but will live with
the default, level-triggered interrupts, to get this thing going and avoid,
for now, setting the SIEL register of the 860. Does anyone have a clue what
serial.c requires as an interrupt vector supporting a generic serial.c
device such as the TI UART (just one port for now) under an 860T?

in routine: startup

	retval = request_8xxirq(state->irq, handler, IRQ_t(state),"serial",
NULL);

What should we put here?

Thank you profusely.
Mike Flynn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
