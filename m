Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AC848EC.92161602@opensource.se>
Date: Mon, 02 Apr 2001 11:39:56 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Leonard Ye <leonard_ye@ylez.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel support of MPC8XX series
References: <20010402092630.6495428826@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> For us, the majority  of  devices  are  memory  cards  like  SanDisk,
> CompactFlash  or  IDE  harddisk  adapters.  On  one  side, the PCMCIA
> package is a lot of overkill here; on the other  side  it  cannot  be
> used  when  you  want to boot from such a device.

Not really true.
It _is_ possible to boot with the PCMCIA package, it's just a bit
harder.
Use an initrd with a scaled-down PCMCIA package to solve it.

But I suggest you try the in-kernel support as a first step.

/ Magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
