Message-ID: <20010501161200.93146.qmail@web9901.mail.yahoo.com>
Date: Tue, 1 May 2001 09:12:00 -0700 (PDT)
From: Freddy Lugo <wilflugo@yahoo.com>
Subject: Re: Image download problem with gdb and DBI 
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20010430214627.AF7E02814D@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> At least it's part of the problem. Another problem
> might  be  missing
> hardware  initialization  and  parameter  passing.
> Usually I let the
> firmware initialize the box and load the linux
> kernel...

The FORMAT was already set to IMAGE on the bdi2000.
Also I tried to make an autoload (LOAD AUTO) from the
BDI and still the image is not downloaded or could not
be found.  On the gdb, the load doesn't download the
image.

I let the MPC750 used the standard initialization
provided on boot/head.S.

Since the kernel image is not found yet, the MMU is
not set (AFAIK), what other initialization could be
needed in order to permit the image download?

Sorry for all the bothering.  I checked the list but I
didn't find information on the issue.

Thanks,
Freddy Lugo


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
