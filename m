Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.1.6.2.20030529131257.01276478@corelis.com>
Date: Thu, 29 May 2003 13:17:06 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: "Brian S. Park" <brian@corelis.com>
Subject: Re: getting Linux working on IBM Walnut demo board 
In-Reply-To: <5.1.1.6.2.20030528150729.0128bdf0@corelis.com>
References: <20030528213503.9676EC6162@atlas.denx.de>
 <Your message of "Wed, 28 May 2003 13:53:08 PDT." <5.1.1.6.2.20030528132553.0128a2f0@corelis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello again,
I need more help!
Some time, when u-Boot is trying to download the linux kernel image over
tftp connection,
I get the following error. Any one have any idea what may be causing it?

Also, I was wondering if it's possible to make u-boot image that will work
with 256KB of ram/flash.
I tried changing TEXT_BASE to 0xFFFC0000 but I get an error during boot.
Something about the reserved memory is less than required. Is this possible?

Thank you.

Brian

ENET Speed is 100 Mbps - FULL duplex connection
ARP broadcast 1
TFTP from server 192.168.1.78; our IP address is 192.168.1.146
Filename 'pImage'.
Load address: 0x100000
Loading: ###########################################ERROR : Receive buffers are
full!

MAL error occured.... ISR = c0100010 UIC = = 220000  MAL_DEF = 2e0000  MAL_ERR=
260000

MAL error occured.... ISR = c0100010 UIC = = 220000  MAL_DEF = 2e0000  MAL_ERR=
260000

MAL error occured.... ISR = c0100010 UIC = = 220000  MAL_DEF = 2e0000  MAL_ERR=
260000
T T T T T


===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x143
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
