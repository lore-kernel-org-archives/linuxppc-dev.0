Message-Id: <m12szKb-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: EST SBC8260 Linux memory mapping rules
To: dan@netx4.com (Dan Malek), linuxppc-embedded@lists.linuxppc.org
Date: Fri, 19 May 2000 22:49:37 -0400 (EDT)
In-Reply-To: <3925EBA0.ABFE1267@embeddededge.com> from "Dan Malek" at May 19, 2000 09:34:24 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>From Dan Malek:

> The zImage should be loaded above the link address by at least the
> amount of memory required by the uncompress/setup functions.  If you
> load it below the address, it could potentially relocate itself on
> top of the kernel or ram disk image.  For example, the uncompress/setup
> functions are linked to run at 0x00400000, based upon the current size
> of the functions, you need to load above 0x00407000.  I would pick
> 0x00480000 or higher, just to not worry about it.

I have loaded the zImage bits at the link address on the SBC8260,
and that works just fine.

On the TQM 860T board, I have sucessfully loaded and booted Linux 2.2.13
from a Srecord version of zImage with the ELF header (first 64k)
stripped out at 0x00200000 (2 MB).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
