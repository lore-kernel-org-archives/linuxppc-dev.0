In-Reply-To: <Pine.GSO.4.21.0003211147040.29509-100000@turing.cs.hmc.edu>
Date: Tue, 21 Mar 2000 23:13:12 +0100
To: Matt Brubeck <mbrubeck@hmc.edu>
CC: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: aty128fb patch on iMac DV
Message-Id: <20000321231312.008626@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 21, 2000, Matt Brubeck <mbrubeck@hmc.edu> wrote:

>> And tell me if it works better ? It includes Kevin
>> _really_latest_changes_ and seems to work on an iMacDV I have here (but I
>> could only test the boot console, there's no linux install on this
>> machine and will never be).
>
>No, sorry. The video still freaks out in any color depth greater than 8.

Well, I just got a report of a working one and mine worked...

Can you send me the results of dmesg and a copy of your MacOS device tree
nodes relating to the ATI (not the whole tree please).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
