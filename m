Subject: 2.6 kernel on Sandpoint
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1079084120.691.16.camel@newt>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 09:35:21 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anybody run the linuxppc_2_5 tree on a Sandpoint recently?

I've got a Sandpoint X2. I've ported linuxppc_2_4_devel to run on it,
and the patch is extremely small. My attempt to do the same thing with
linuxppc_2_5 has run into a problem:

Once init opens the console device, the serial driver unmasks irq 4. At
this point irq 4 is permanently asserted, even though the interrupt
register in the UART claims that there is no interrupt.

This should be the same on both X2 and X3 Sandpoints, leaving me curious
as to whether the X3 works with the current tree.

- Adrian Cox
http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
