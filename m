Date: Thu, 1 Nov 2001 10:04:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Lots of changes to PReP booting
Message-ID: <20011101100454.A25511@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011025175915.A6439@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011025175915.A6439@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 25, 2001 at 05:59:15PM -0700, Tom Rini wrote:

> 2) Notify the user where we are just after we init the serial & vga
> ports.
> 3) Notify the user where the residual data is only if we have it.  If we
> don't have it tell the user that too.
> 4) _Always_ relocate the zImage, and if we have an initrd, always
> relocate that too.
> 5) Kill the checks for things being above 16M.  We've now garrenteed
> that initrd_start will be valid, and hold_residual and cmd_line are part
> of the wrapper and thus must be close to the 8M mark, or wherever we've
> relocated the wrapper to after boot.

These parts of the patch are now in the linuxppc_2_4_devel tree.  If you
haven't tested these changes yet and have a machine which you can
reboot, please try these changes.  They quite probably won't harm
anything, and do fix a few known problems.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
