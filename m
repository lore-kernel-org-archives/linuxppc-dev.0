Message-ID: <3B7C3E51.52B43280@mvista.com>
Date: Thu, 16 Aug 2001 17:42:41 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Jure Menart <jure@kom.org>
Cc: linuxppc dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: linux-2.4 & 405gp & other stuff
References: <20010816175511.A1012@hannanges.teden-mladih.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jure Menart wrote:
>
> Hello everyone,
> I've tried to compile linux-2.4 kernel (I tried with sources from
> kernel.org and with sources from denx.de) but it wasn't successful.

Probably not.  You need to use the latest 2_4_devel sources from
BitKeeper or one of the CVS/rsync sites.  See penguinppc.org for details.

> Kernel was configured for PPC 4xx, Oak Machine type - it had included
> only parallel port, serial console, initrd, ide... really 'bare' kernel.

That's hardly a "bare" kernel......A serial port with an attached
initrd ram disk is a "bare" kernel.  You have selected nearly everything
that is supported.  I'm not sure if Oak will even run properly.  We
have been using Tivo as the 403 test platform.

> Next question I have is: What exactly is 'Machine type' in Platform
> support in kernel configuration? What are 'oak' and 'walnut'? Is this
> like description of board?

Ummm....yeah.  The Oak is a 403GCX IBM reference board.  The Walnut
is an IBM 405GP reference board.

> IBM 405gp has included ethernet controller - are there any drivers for
> it?

Yep.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
