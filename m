Date: Wed, 17 Oct 2001 10:08:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Vacca <svacca@valcom.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd offset in zImage getting mis-aligned?
Message-ID: <20011017100832.A32556@cpe-24-221-152-185.az.sprintbbd.net>
References: <01C156FF.63187140.svacca@valcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01C156FF.63187140.svacca@valcom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 17, 2001 at 11:32:21AM -0400, Steven Vacca wrote:

> I am porting a version of Redhat's embedded linux kernel to
> a new custom designed bd with the mpc860.  I am using a
> local RAM disk on this new bd.

Erm, you might want to look at the bits in the linuxppc_2_4 or
linuxppc_2_4_devel tree (http://penguinppc.org/dev/kernel.shtml).  Prior
to a few days ago, we did some slightl mis-calculations on where to put
our image and/or ramdisk (they were off by 12bytes or so).  I'm not sure
if this is your problem tho..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
