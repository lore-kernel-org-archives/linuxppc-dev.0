To: linuxppc-dev@lists.linuxppc.org
Subject: PCI Detection/ programming / GPIB
Reply-To: kozioziemski1@llnl.gov
From: Bernard Kozioziemski <kozioziemski1@llnl.gov>
Date: 07 Jan 1999 09:31:36 -0800
Message-ID: <m3k8yz3s7b.fsf@unites9500.llnl.gov>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Greets,
I've been running LinuxPPC for a few months now, but I want to become less
dependent on MacOS. I would really like to use LinuxPPC to run some data
collection software similar to what I have under MacOS. 

I have a National Instruments PCI GPIB (IEE-488) card installed in my
PowerMac 9500. There is some work on the x86 front to support GPIB, so I
thought I'd start there. Unfortunately, the card is not found by linux when
booting. /proc/pci lists 3 devices: Apple Bandit, VGA compat controller
(grpahics card) and Apple Grand Central. I'm not sure where to start in
detecting this board, and I was wondering if someone on this list could
give me a few pointers to (beginner :) info, or example code. Thanks,

Bernie Kozioziemski

-- 
kozioziemski1@llnl.gov
(925)424-6317

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
