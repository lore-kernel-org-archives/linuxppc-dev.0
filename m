Message-Id: <s8b6c9c1.032@mail.frequentis.com>
Date: Fri, 25 Feb 2000 18:27:46 +0100
From: "Ralf HECKHAUSEN" <RHeckhau@frequentis.com>
To: "<"<linuxppc-embedded@lists.linuxppc.org>
Subject: no serial console
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For a certain application we need all serial ports. Is it possible to have no serial console? Even if I undefine CONFIG_SERIAL_CONSOLE, I still need to have to link /dev/console link to a ttySx. Otherwise I cannot log in through telnet.
How can I define /dev/console without using a serial port?

Cheers,
Ralf


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
