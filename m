From: hollis@austin.ibm.com
Date: Wed, 26 Sep 2001 08:24:55 -0500
To: Robert E Brose II <bob@kunk.jriver.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Stock 2.4.10 kernel on RS6K 7248
Message-ID: <20010926082455.A434@austin.ibm.com>
References: <20010926045943.4528.qmail@kunk.jriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010926045943.4528.qmail@kunk.jriver.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 25, 2001 at 11:59:43PM -0500, Robert E Brose II wrote:
>
> 1) When booting the 2.4.10 kernel as opposed to the 2.2.18 kernel, the
> virtual consoles have the character and attribute REVERSED so there is
> junk on the screen when one first switches. Subsequent characters
> displayed work properly however. 2.4.10 is using the VGA console
> driver in this case because the frame buffer driver wasn't
> compiled in.

This problem has been fixed in a large video driver patch that Geert posted a
month or two ago.

> 2) A little more problematic, I'd like to run X on this (it IS a
> workstation).
[snip]

I don't know... isn't it a requirement that you can run X before you can call
it a workstation? ;)

At any rate, I don't think anyone except you has tried to hack 2.2's e15fb
into 2.4...

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
