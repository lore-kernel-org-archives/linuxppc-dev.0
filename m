From: Michael Thompson <mickey@berkeley.innomedia.com>
Message-Id: <200003160716.XAA19499@berkeley.innomedia.com>
Subject: G3/IDE/BootX/2.3.49 woes
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 15 Mar 2000 23:16:39 -0800 (PST)
Cc: mickey@berkeley.innomedia.com (Michael Thompson)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




I've got a B/W G3. I am able to boot 2.2.15 using bootX 1.2b3
without any problems.

However, with 2.3.49, the IDE controller doesn't seem to
be generating interrupts.

The controller (CMD646) is recognized, the drives are
identified.

I can see that irq 26 has been assigned to the device, and
this irq is enabled.

The controller's MRDMODE register (0x71) is initialized to
0x00, so it should be generating interrupts.

However, no interrupts are received from the device.

Could this be an interrupt routing issue?




Can someone let me know how I can boot linux on a G3
using OpenFirmware instead of bootX? Maybe I will
have better luck with OFW.o

Thanks very much!

-Michael Thompson
mickey@berkeley.innomedia.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
