Date: Fri, 29 Aug 2003 13:18:25 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Corey Minyard <minyard@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
Message-ID: <20030829131824.B18608@home.com>
References: <3F4FB0F3.9090906@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F4FB0F3.9090906@acm.org>; from minyard@acm.org on Fri, Aug 29, 2003 at 03:00:51PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 29, 2003 at 03:00:51PM -0500, Corey Minyard wrote:
> I have a debugger that runs in an application that requires access to
> the SE and BE bits.  The following patch adds that capability to
> 2.4.21-ben1.  I have tested this, and gdb still seems to correctly step
> out of signal handlers, and it seems to work for 4xx.  Does this look ok?

Please change MSR_SE->MSR_DWE in the 4xx-specific sections.  Also,
a comment should be added to each generic section use of MSR_SE to
make it clear that this is the BookE/4xx MSR_DWE.

-Matt

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
