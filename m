From: "Navin Boppuri" <nboppuri@myiagent.com>
To: "Kirk Haderlie" <khaderlie@vividimage.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: communication with the FADS823 through ethernet
Date: Tue, 20 Jun 2000 14:02:07 +0100
Message-ID: <NEBBLLEGJMLHPJEFEOKPGECLCAAA.nboppuri@myiagent.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <319E391E2049D311843500609457383D07FC65@exchange.vividimage.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Kirk,

Thanks for the 8xxrom. I was not able to check my mail and so did not know
that you sent me the code.

You put the code for tftp in the rom code. I am looking at the RedHat
embedded developement kit and the way they work with the MBX board is that
they use a DHCP service to actually actually assign the target an IP number
using its ethernet address. The ethernet address is already set by EPPCBug.
I dont think that is the case with the 8xxrom. The MBX debugger, EPCbug uses
the NIOT command to get the ethernet address. Is there some way we can set
the ethernet address in the 8xxrom for the FADS board? The MBX then uses
tftpboot to boot the board through a network. Any way to simulate this on
the FADS?

-----Original Message-----
From: Kirk Haderlie [mailto:khaderlie@vividimage.com]
Sent: Tuesday, June 20, 2000 7:13 PM
To: 'Navin Boppuri'
Subject: RE: Loading the kernel on the FADS 823 board


Navin,

	Using the 8xxrom I sent, you can set up a tftp server on a linux box
and load the kernel via tftp.  It require you to customize the tftpconfig.h
for your enviroment.  You need to specify the MAC address and IP for both
the server and the FADS board.  If you have question just let me know.

-----Original Message-----
From: Navin Boppuri [mailto:nboppuri@myiagent.com]
Sent: Tuesday, June 20, 2000 5:00 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Loading the kernel on the FADS 823 board



I am total newbie to embedded systems. I just got the 8xxrom working on my
FADS 823 board. It boots up and fine and I see a prompt. Can someone tell me
how do I load the kernel onto the board. How can I get the ethernet
connection up and make it work like the MBX board? The basic question is,
what and how do I go to the next step?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
