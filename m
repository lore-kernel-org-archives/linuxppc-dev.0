Date: Fri, 18 Apr 2003 14:00:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Fix RPX and add flash-burner in linuxppc_2_4_devel
Message-ID: <20030418210022.GA7065@ip68-0-152-218.tc.ph.cox.net>
References: <20030416182453.GP20197@host109.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030416182453.GP20197@host109.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 16, 2003 at 12:24:53PM -0600, Cort Dougan wrote:

> This patch fixes the RPX boot which was generating a bad boot image (it was
> an ELF) and will do the 'cp' command line correctly, too.

That's a "feature".  Newer versions of the rpx fw boot ELF.  And IIRC,
if you need to convert it to srec later on, you can't have already
stripped off the ELF header (for objcopy).

> This patch also adds a boot image that will burn itself (and an initrd if
> present) to the flash on the RPX.

That's interesting.  Perhaps generating the FLASHBURN srec file instead
of just including it would be a bit better of an approach 'tho.

> http://www2.fsmlabs.com/~cort/rpx.patch.gz

What're the FINISH_EXCEPTION2 changes for?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
