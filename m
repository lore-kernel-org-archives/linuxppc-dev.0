To: linuxppc-embedded@lists.linuxppc.org
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Subject: Interrupt handling triggered by GPIO-input on 405EP?
Date: Tue, 18 May 2004 14:29:46 +0200
Message-ID: <c8cvjr$m40$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello there,

I've done some initial coding with the ibmgpio driver with my PPC405EP
(PPChamelon) board, and inspired by the "gpio_test.c"-application, I've
succeeded in turning on some attached LEDs on some of the ports, and
reading whether some of the others ports are set high or low using the
(manually) attached pushbutton-switches.

However, the way the application is at the moment I need to poll the
input-ports every so often in order to detect a pushbutton-activation.
Hence, I would like to register an interrupt-handler (of some sort) that
informs me when these events occur. Is that somehow possible?

Best regards,
  Martin Egholm


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
