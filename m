Message-ID: <3AD9B0B2.D73C8AEF@erols.com>
Date: Sun, 15 Apr 2001 10:31:14 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RTL8139 PPC testing?
References: <3AD8F1A3.8B3A82E7@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jeff Garzik wrote:

> Is anybody here with a PPC and an 8139 card, and willing to test?
>
> If so, can you try 8139too version, 0.9.16?  Just posted at
> http://sourceforge.net/projects/gkernel/   It requires 2.4.3 kernel.

Just for the record, I'm running a 450MHz Sawtooth:

Linux dp2 2.4.3-pre4 #8 Wed Mar 14 22:54:45 EST 2001 ppc unknown

02:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)

8139too Fast Ethernet driver 0.9.15 loaded
eth1: RealTek RTL8139 Fast Ethernet at 0xd2017000, 00:a0:4b:03:28:92, IRQ
54
eth1:  Identified 8139 chip type 'RTL-8139A'
eth1: Setting 100mbps full-duplex based on auto-negotiated partner
ability 41e1.

I have this running my internal network and I haven't had any problems
with it at all.

--Nelson Abramson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
