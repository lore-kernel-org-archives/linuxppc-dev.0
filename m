Message-ID: <37E9244D.4D03B068@netx4.com>
Date: Wed, 22 Sep 1999 14:47:41 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Christophe Reinbold <Christophe.Reinbold@sxb.bsf.alcatel.fr>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ramdisk problem with 2.3.18 on mpc8xx boards.
References: <37E8F580.BCCD20AB@sxb.bsf.alcatel.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christophe Reinbold wrote:

> 
> We correctly open ramdisk files but reading them just returns
> zeroed out buffers.

The ramdisk is generically broken like all of the file systems
not updated since the "new" 2.3.x VM strategy has been implemented.

Since it really affects us with the embedded processors, I have
taken some time to look at it, but don't yet have it fixed.

It would be nice if someone familiar with this software would just
drop by and fix it :-).  I have other things I need to be working
on.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
