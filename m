Message-ID: <20010926203225.8705.qmail@kunk.jriver.com>
Subject: Re: Stock 2.4.10 kernel on RS6K 7248
In-Reply-To: <20010926082455.A434@austin.ibm.com> "from hollis@austin.ibm.com
 at Sep 26, 2001 08:24:55 am"
To: hollis@austin.ibm.com
Date: Wed, 26 Sep 2001 15:32:25 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User hollis@austin.ibm.com says:
> On Tue, Sep 25, 2001 at 11:59:43PM -0500, Robert E Brose II wrote:
> >
> > 1) When booting the 2.4.10 kernel as opposed to the 2.2.18 kernel, the
> > virtual consoles have the character and attribute REVERSED so there is
> > junk on the screen when one first switches. Subsequent characters
> > displayed work properly however. 2.4.10 is using the VGA console
> > driver in this case because the frame buffer driver wasn't
> > compiled in.
>
> This problem has been fixed in a large video driver patch that Geert posted a
> month or two ago.

Ok, I'll dig that out. I WAS impressed that all the other fixes made it
into the stock kernel source.

> > 2) A little more problematic, I'd like to run X on this (it IS a
> > workstation).
> [snip]
>
> I don't know... isn't it a requirement that you can run X before you can call
> it a workstation? ;)

Touche, it WAS a workstation when it was running AIX ;)

> At any rate, I don't think anyone except you has tried to hack 2.2's e15fb
> into 2.4...

Then I'll keep hacking :)

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
