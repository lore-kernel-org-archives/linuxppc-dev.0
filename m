Date: Wed, 3 Oct 2001 11:32:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
Message-ID: <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011003130559.F31866@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011003130559.F31866@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 03, 2001 at 01:05:59PM -0400, Kent Borg wrote:

> We use cvs internally and I am trying to get all the daily patches out
> of Bitkeeper and into a cvs module.  Are others doing this?  Is it
> reasonable?  If so, how are you doing it?

Doing this daily isn't too horrid.  Use the rsync version and tag
a tree daily.  Thats more or less what I do.

> I tried using "bk export" to generate a patch file I could apply to my
> cvs tree, but there are Id keywords that cvs honored the last time
> around making the patch not apply properly.

Yeap.  One thing you can try is to un-export the keywords first.  Ie
change them back into BK Id: %x% %..%

> Finally, I tried writing some perl to post-process the "bk export"
> patch to remove the simple Id changes.  Cool, but bunches of files, at
> least in yesterday's pull, have changes up near the Id and so are part
> of the same patch hunk, and catching that in a perl script is going to
> be a lot harder.

Smaller hunks and change 'em back into the unexported form?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
