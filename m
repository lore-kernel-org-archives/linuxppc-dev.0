Message-ID: <3E3CBF2E.9030107@gmx.de>
Date: Sun, 02 Feb 2003 14:48:14 +0800
From: Michael Habermann <mhabermann@gmx.de>
MIME-Version: 1.0
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Trying to program u-boot into flash using BDI2000
References: <995FF289C9D69747A09E42992644595405B23639@penguin.adic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


brian.auld@adic.com wrote:

>WORKSPACE   0x000040000      ; RAM buffer for fast flash programming
>
>
Try disabling this line. It can only be used when your RAM is confirmed
working.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
