Date: Wed, 11 Jun 2003 06:53:52 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Bill Fink <billfink@mindspring.com>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: init does not run on 405GP system
Message-ID: <20030611045351.GA20132@pengutronix.de>
References: <20030610232157.2f012435.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20030610232157.2f012435.billfink@mindspring.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 10, 2003 at 11:21:57PM -0400, Bill Fink wrote:
> This is probably not the issue, but you do have CONFIG_BINFMT_ELF
> enabled in the kernel, don't you (although I would assume you would
> get some kind of kernel error message when you tried to exec /sbin/init
> if CONFIG_BINFMT_ELF wasn't enabled).

The option is always defined y for PowerPC, you cannot deselect it. But
I've checked it anyway ;)

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
