Date: Mon, 21 Jul 2003 10:45:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: rsync mirror missing files?
Message-ID: <20030721174539.GB745@ip68-0-152-218.tc.ph.cox.net>
References: <20030720145944.GA24386@bitwiser.org> <20030721143107.GA745@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030721143107.GA745@ip68-0-152-218.tc.ph.cox.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 21, 2003 at 07:31:07AM -0700, Tom Rini wrote:
>
> On Sun, Jul 20, 2003 at 10:59:44AM -0400, Ryan Boder wrote:
>
> >
> > The mvista rsync mirror seems to be missing some files right now, specifically..
> >
> > fs/ncpfs/Makefile
> > drivers/net/wireless/Makefile
> >
> > Anyone know why? I checked the BK tree and they aren't missing there.
>
> Disk space problems, I'm looking into this now.  Thanks.

Okay, space has been made (and a bigger disk being looked into), and
all of the rsync mirrors have been re-built.  Let me know if you find
any more issues.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
