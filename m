MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14952.53532.864761.156822@chiark.greenend.org.uk>
Date: Fri, 19 Jan 2001 23:43:24 +0000 (GMT)
From: Chris Emerson <cemerson@chiark.greenend.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <19341214163142.29221@mailhost.mipsys.com>
References: <14952.48929.34769.196323@chiark.greenend.org.uk>
	<19341214163142.29221@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, 19 Jan 2001, Benjamin Herrenschmidt wrote:

> >Does that mean the mode/depth set by OF, or the one set by the
> >vmode kernel cmdline option?
>
> The one set by OF. If the video driver supports it (that should be
> the case of most drivers used on ppc with 2.4), any video mode set
> either via cmdline, fbset, etc... or X if X is using fbdev's.

Ok, I think I meet the criteria then.  I'll do some experimentation.

> With a cable from the G4's modem to another modem, and some hackery
> (already present in arch/ppc/xmon/start.c, I suggest you look at that
> file), it's possible but tricky.

Ok.  Is there a fundamental reason which prevents it being possible to
use the USB keyboard, or just hard work?

> >I'm currently running 2.4.1pre7 rsynced from the bk tree.
>
> pre8 is already there ;)

Well, unless there are any vital fixes, I'll hold off for a few days.
:-)

Cheers,

Chris
--
Chris Emerson, obsessed Cambridge juggler
E-mail: cemerson@chiark.greenend.org.uk
Web page: http://www.chiark.greenend.org.uk/~cemerson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
