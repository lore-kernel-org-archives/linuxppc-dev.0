Date: Thu, 8 Jul 2004 18:04:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: what's the value of CONFIG_8xx_UART?
Message-ID: <Pine.LNX.4.60.0407081800340.1772@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   under MPC8xx CPM Options, what's the purpose of selecting

   [ ] Use UART         (representing option CONFIG_8xx_UART)

i mean, i already have SMC1 serial port support, and a working
console, and SMC1 is on a UART.  so what else would this give me?
there is no help for this option.  if i select it, i get the chance of
now selecting "SMC2 for UART", which kind of implies that SMC1 is the
default anyway, which is already working, etc, etc.

   thoughts?  this is going to lead in to yet another question
regarding SMC1/SCC3 co-existence.  but now, time for supper.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
