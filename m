From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 23 Apr 2003 19:08:46 -0700
To: Chris Heintzelman <heintz@mail.utexas.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: booting MGT5100?
Message-ID: <20030424020846.GA1283@rover.farnsworth.org>
References: <3EA70BDE.9080609@mail.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EA70BDE.9080609@mail.utexas.edu>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Apr 23, 2003 at 09:55:42PM +0000, Chris Heintzelman wrote:
>
> I noticed that a few months ago someone mentioned booting Linux on one
> of these boards (MGT5100).  There didn't seem to be much discussion
> though; I have one of these boards and would also like to boot linux on
> it, I'm wondering if anyone can point me to a good starting point on
> this?  Any help is appreciated.  I've got a toolchain and kernel built
> but am having no luck with it.
>
> Thanks,
> Chris H.

I've been working with Kent Borg to bring up linux on the mgt5100.
As Peter said, they're running it on an icecube, while I have a glacier
system.  The serial driver seems reasonably solid.  I've been working
on an ethernet driver and started testing it today.  It has sent and
received a few packets but lots of cleanup remains.  I plan to put up a
bk repository on source.mvista.com in a couple of weeks.  I could send
you a tarball if you'd rather not wait.

-Dale Farnsworth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
