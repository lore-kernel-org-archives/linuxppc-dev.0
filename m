Message-ID: <3C94D78E.3010100@embeddededge.com>
Date: Sun, 17 Mar 2002 12:51:10 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
References: <0203170703.AA00587@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> But Troy's personal preferences shouldn't affect the public tree, should they?
> If 9600 is the default baud rate for all of Linux, why should one port be
> different?

I didn't know there was a "default" baud rate for Linux.  I think the lowest
I have ever seen is 9600, but I certainly wouldn't call it a default.  It
seems every one of the boards I have uses something different,

The debug console serial port rates are either provided by passing some
bootloader information to the kernel or by a kernel command line option.
Either one is locally configurable.

> .... Who is the maintainer with authority over this? Would s/he accept a
> patch to axe that 115200 line out?

It shouldn't be a hard-coded value.  It should at least be the standard Linux
command line option.  Bootloaders should simply use the port as it was
configured by the boot rom.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
