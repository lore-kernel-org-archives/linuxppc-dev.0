Date: Thu, 24 Oct 2002 19:01:19 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: PrPMC800 interrupt problem
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Message-Id: <37671D04-E772-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When trying to use the linuxppc_2_4_devel on a PrPMC800, the system stops
responding to external interrupts after the first serial interrupt. Many
things works, since the system correctly gets its IP address via DHCP.

The system handles a little more than 100 interrupts that gets routed to
'e100intr', then it starts up my shell that does a write to the console.
This write triggers an interrupt that gets routed to 'rs_interrupt_single'
. After this no more interrupts are received, but 'rs_interrupt_single' is
called from the timer task in the serial driver, but the ethernet is
totally dead. Anybody that has a good idea what to do about this?

Regards

Anders Blomdell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
