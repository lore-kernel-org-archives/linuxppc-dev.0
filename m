Date: Wed, 12 Mar 2003 12:22:40 -0700
From: Matt Porter <porter@cox.net>
To: Eric Seppanen <eds@reric.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cache control functions
Message-ID: <20030312122240.B28769@home.com>
References: <20030312130214.A7123@reric.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030312130214.A7123@reric.net>; from eds@reric.net on Wed, Mar 12, 2003 at 01:02:14PM -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 12, 2003 at 01:02:14PM -0600, Eric Seppanen wrote:
>
> I'm writing a driver module, for a pci device that lives in a 405GPr
> based system.  I notice that the 405 doesn't seem to have a consistent
> cache after the pci device busmasters a bunch of data into SDRAM (or
> before it pulls data out), so I think the thing I'm supposed to do is
> call (depending on direction) one of these:

<snip>

> Is this intentional or an oversight?  I can't see how I can write a
> driver for a busmaster device (that will work on a 405) without them.

Use the standard API described in Documentation/DMA-mapping.txt
You will find that there are PPC-specific (sort of, ARM has the same
names) versions of generic PCI DMA API defined in include/asm-ppc/io.h
Those can be used on on-chip or other non-PCI type device (stuff on
the EBC for 4xx).

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
