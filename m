MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16134.1372.970689.841218@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jul 2003 08:53:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jasper Spaans <jasper@vs19.net>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: cleanup of linux-2.5/drivers/block/swim3.c
In-Reply-To: <20030704104616.GA29229@spaans.vs19.net>
References: <20030704104616.GA29229@spaans.vs19.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jasper Spaans writes:

> Attached is a patch which should solve compilation issues related to the new
> irqhandler interface, and the deprecation of cli()/sti() for the
> swim3-driver.

Have you audited the driver with respect to changes in the block
device layer?  I haven't, but I think it needs to be done.  It's
possible that the necessary changes have already been done but I'm not
sure.  And I don't want to send Linus a patch that would change it
from broken and non-compiling to broken but compiling.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
