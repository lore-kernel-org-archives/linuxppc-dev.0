Date: Sat, 26 Feb 2000 09:35:24 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000226163524.ZM9177@saguaro.lan>
In-Reply-To: Sean Chitwood <darkmane@w-link.net>
        "Help w/ gdb" (Jan 15, 11:12pm)
References: <Pine.LNX.4.10.10001152247220.28099-100000@darkmane.w-link.net>
To: LinuxPPC Developers List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Help w/ gdb
Cc: darkmane@w-link.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Jan 15, 11:12pm, Sean Chitwood wrote:

[Regarding gdb...]

> When I attempt to debug an assert/crash as I bring up the stack
> trace I notice that some of the frames point only to the ending
> curly brace of a function (Not always the one it says is being
> debugged).  I cannot examine variables, or learn anything else
> productive about the situation.

I had sent some earlier replies to Sean suggesting a couple of
workarounds.  These workarounds should no longer be necessary if you
build gdb with the current development sources from
sourceware.cygnus.com.

See http://sourceware.cygnus.com/gdb for more information on how to
download these sources.  (If you're going to download via ftp, you'll
want to wait for next week's snapshot as it will contain several
shared library fixes.)

Kevin

--
Kevin Buettner
kev@primenet.com, kevinb@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
