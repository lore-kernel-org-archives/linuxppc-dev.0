Message-ID: <3E663ED6.1030808@corelis.com>
Date: Wed, 05 Mar 2003 10:15:50 -0800
From: John Chan <john@corelis.com>
Reply-To: john@corelis.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: u-boot and ibm boot
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, folks,

my walnut board comes with ibm's boot "rom monitor" (and source code in
CD). I wonder if I can load a linux kernal image (EDLK for example) from
it? I heard that there is another boot code called u-boot. I wonder if
anyone had use it before on Walnut? if yes, do you recommand me to use it?

I would like to add an audio PCI board in the walnut board and would
like to configure/diagnosis the board during the boot time. IBM come
with their ROM monitor source code but the compiler is not free (High
C). I want to have capability to modify the rom monitor/boot loader to
add my own diagnostic code.

Do you think u-boot is good enough?


--jC


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
