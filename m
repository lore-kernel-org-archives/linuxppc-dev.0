Date: Sun, 5 Jan 2003 21:07:30 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing I2C from User Space
Message-ID: <20030105210730.B22675@home.com>
References: <001901c2ad79$bd3f8560$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001901c2ad79$bd3f8560$370da8c0@aman>; from aman@mistralsoftware.com on Fri, Dec 27, 2002 at 12:59:49PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Dec 27, 2002 at 12:59:49PM +0530, Aman wrote:
>
> Hi,
>
> Iam working on IBM 440gp. I need to access the IIC registers from the
> user space. So I wrote a driver mmap entry point. But I noticed that the
> function remap_page_range () takes physical address as unsigned long which
> is 32 bits. How do I remap the IIC registers which lie in the 36 bit
> physical address space?

There's a reference to a patch in one of my changeset entries.  It pays
to keep current with the development trees.  See the changesets in your
local BK tree or browse the linuxppc-commit archives.

BTW, why the need to manipulate the registers directly?

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
