In-Reply-To: <1091647026.4233.95.camel@localhost.localdomain>
References: <1091647026.4233.95.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <50DFAECF-E650-11D8-852B-003065F9B7DC@embeddededge.com>
Cc: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: rpx8260_defconfig problems
Date: Wed, 4 Aug 2004 15:56:03 -0400
To: Jeff Angielski <jeff@theptrgroup.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 4, 2004, at 3:17 PM, Jeff Angielski wrote:

> I get no output on my serial console.  When I look at the log_buf using
> the BDI, the last message I see is "Warning: real time clock seems
> stuck".

Your boot rom isn't enabling the timebase in the HID0 register.
I think we used to do that in zImage bootloader, but then boot
roms got fixed and we removed it.

> 1) Does anybody else have the EP8260 working with their linux?

Yes.

> 2) If so, which kernel are you using?  linuxppc-2.4?

Yes.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
