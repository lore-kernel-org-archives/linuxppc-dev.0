Date: Fri, 28 Sep 2001 08:18:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.10 stable tree
Message-ID: <20010928081828.T23005@cpe-24-221-152-185.az.sprintbbd.net>
References: <200109281516.LAA00192@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200109281516.LAA00192@orchid.cspi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 28, 2001 at 11:07:18AM -0400, Brian Waite wrote:

> I have been working on a stable port of the MVME5100 from the devel tree. I
> had everything working from 2.4.9 and I got onot other projects. I just
> grabbed the 2.4.10 stable tree and noticed the arch/ppc/boot/simple directory
> has been removed. I was using simple/head.S to bring up the board. What
> should I be using now? Have you abandoned a simple head.S layout and require
> all baords to have their own head.S now? I am just making sure I am not
> missing something.

Er.  linuxppc_2_4 (the 'stable' branch) does not have the new boot stuffs
yet.  I will once things are done however.  Since you're moving the mvme5100
stuff from linuxppc_2_4_devel into linuxppc_2_4 (If I'm reading this right),
just move the arch/ppc/boot/simple stuff as well.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
