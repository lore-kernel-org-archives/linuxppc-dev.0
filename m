Date: Thu, 11 Apr 2002 17:41:51 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: andrew may <acmay@acmay.homeip.net>, Armin <akuster@pacbell.net>,
	John Tyner <jtyner@cs.ucr.edu>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020411174151.G18158@ecam.san.rr.com>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net> <20020411153642.C18158@ecam.san.rr.com> <20020411231056.GJ759@opus.bloom.county> <20020411162849.F18158@ecam.san.rr.com> <20020412000341.GM759@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412000341.GM759@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 05:03:41PM -0700, Tom Rini wrote:
> I assume once the custom HW is 'ready', you'll be able to stop doing
> that tho.  I think you'll spend more time trying to get everything just
> right than you would building 2 kernels a few times (I bet much of the
> pain comes from the current kbuild crap.  You might wanna play w/ the
> current kbuild-2.5 stuff if you're going to pick a kernel rev & stay for
> a while, it gets the deps right so you only recompile the needed files
> in cases like this).

We already have a few boards running but right now we have to fight over
them. With the Walnuts we can build and test kernel changes without
holding up other people using the boards.

So far doing 2 builds has been ok, but it shouldn't be too much work to
get things working for both. I am not looking at the code now, but for
a 405 you just need to do a board header and a C file. The amount of
work these things do is small, but they all define the same functions.
That doesn't lend itself to working for more than one board. It should
be easy enough to put those functions in a structure do things dynamicaly.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
