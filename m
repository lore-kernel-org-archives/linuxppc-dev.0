Date: Mon, 14 Jun 2004 19:38:41 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix missing option in binutils version check
Message-ID: <20040614173841.GA3247@suse.de>
References: <20040605074341.GA15279@suse.de> <20040608112556.GA21447@suse.de> <20040610001605.GH18212@smtp.west.cox.net> <20040614091530.GA18482@suse.de> <20040614162359.GA7798@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20040614162359.GA7798@smtp.west.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Mon, Jun 14, Tom Rini wrote:

> > Everyone who wants to build the latest and greatest kernel can also
> > update binutils, its a no-brainer.
>
> ... which does, or doesn't compile a kernel?  Does the latest and
> greatest binutils and gcc automatically pass down -many, or does it fail
> to compile because the assembler needs -many, but it's not being passed
> along.  That's what I asked.

plain gcc 3.2.3 + binutils 2.15.91.0.1 is a challenge, because it passes
-mppc instead of -many.

> And everyone who wants to build the latest and greatest stable kernel
> should probably stick with a stable release of binutils and gcc.  But
> that's just my 2 cents. :)

Lets just declare the hammer branch as stable, and older junk as
unstable.

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
