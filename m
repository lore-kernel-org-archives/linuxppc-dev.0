Message-ID: <3B4087A8.702@galileo.co.il>
Date: Mon, 02 Jul 2001 17:39:36 +0300
From: Rabeeh Khoury <rabeeh@galileo.co.il>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux SMP
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,

Does any one know of a document how to develope an SMP kernel on PowerPC
based platform ?

And if any one can please explain the boot process ?
I have CPU #0 initializing the whole system then CPU #1 is given bus
grant and executes code from the eeprom which is basically only
branching to address 0x0 ! Is this enough ? what CPU #1 should do next ?

Regards,
Rabeeh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
