Message-ID: <395260E5.C7592DE3@embeddededge.com>
Date: Thu, 22 Jun 2000 14:54:29 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: Dan Malek <dan@netx4.com>, "Mark S. Mathews" <mark@absoval.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
References: <Pine.LNX.4.21.0006221435370.3102-100000@sunapee.transcept.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pavel Roskin wrote:

> I know that program. FLASH_MEM_SIZE is a small number used only in the
> first mmap() to determine the size of the flash.

Yes, but then it re-maps based upon the flash devices found....but I'll
bet I don't map the top boot sector.......

> ..... If you make it so big
> that (int)(FLASH_MEM_ADDR+FLASH_MEM_SIZE)==0 then mmap() fails.

So, this should be a pretty obvious boundary condition bug in
drivers/char/mem.c or one of the Linux MM functions.  You want to
learn about MMUs?  Go check some of those files for inspiration......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
