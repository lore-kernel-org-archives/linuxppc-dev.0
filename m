Message-ID: <3B853507.31F4ADAC@mvista.com>
Date: Thu, 23 Aug 2001 12:53:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Linux Kernel <pakernel@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Kernel and MPC 8240
References: <20010823053911.20714.qmail@web20206.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Linux Kernel wrote:

> When I looked at linux source code there are some
> header files related to 8260 in asm-ppc directory.

The 8260 is not an 8240.....don't look at those files.

> I was wondering if I have to do any modifications to
> kernel code to work with PowerPC 8240?

You need some kind of a board definition and configuration
so you get the PCI and I/O devices configured properly.
Take a look at the Sandpoint stuff.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
