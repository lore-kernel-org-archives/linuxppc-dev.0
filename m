In-Reply-To: <1091811981.4179.20.camel@localhost.localdomain>
References: <1091647026.4233.95.camel@localhost.localdomain> <1091811981.4179.20.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E2044456-E7D9-11D8-BF1B-003065F9B7DC@embeddededge.com>
Cc: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: rpx8260_defconfig problems
Date: Fri, 6 Aug 2004 14:53:19 -0400
To: Jeff Angielski <jeff@theptrgroup.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 6, 2004, at 1:06 PM, Jeff Angielski wrote:

> 1) arch/ppc/platforms/rpx8260.h defined it's own bd_info structure
> which
> was not consistent with u-boot.

Just realize the default configuration for this board uses the EP boot
rom.  Don't mess this up for the default build selection of zImage.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
