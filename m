Message-ID: <42AB6BE23C29D511831E0002B3202488199A86@messenger.radlan.co.il>
From: Ofer Rashuk <OferR@Radlan.co.il>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: signals from interrupt
Date: Sun, 23 Dec 2001 09:18:47 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am running MontaVista hardhat 2.4.2. linux kernel on a MPC8240 cpu with
a pci bus,NVRAM device ,64M ram and 32M rom (flash).
basically my application is running very well i have created all the threads
i needed and all other initialization are almost done.
the last problem i have regards interrupts.
on my target i have a dual UART 16550 device, one of it's ports used by the
kernel (kprintf,etc...) the other port i need to use for my own application.
in order to use it i need to receive an interrupt (mean RX interrupt), now
since there are no interrupts available out side of the kernel i thought of
using signals.
what i wanted to do is to get the interrupt with in the kernel and to send a
signal to the application, the problem is that every method i tried to
implement that did not succeed, can any body help me dealing with this
issue.

thanks in advance.




Ofer Rashuk-Rosenthal.
mailto:oferr@radlan.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
