Date: Thu, 4 Oct 2001 09:25:12 -0400
From: Kent Borg <kentborg@borg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BK to CVS?
Message-ID: <20011004092511.A3914@borg.org>
References: <20011003130559.F31866@borg.org> <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011003113245.B18196@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Oct 03, 2001 at 11:32:45AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Oct 03, 2001 at 11:32:45AM -0700, Tom Rini wrote:
> Doing this daily isn't too horrid.  Use the rsync version and tag
> a tree daily.  Thats more or less what I do.

I might switch to that.

But won't I still have a problem of our cvs expanding keywords
breaking the next patch that gets too near them?

> Yeap.  One thing you can try is to un-export the keywords first.  Ie
> change them back into BK Id: %x% %..%

I don't understand.

> Smaller hunks and change 'em back into the unexported form?

Again I don't think I understand what you mean by "unexported form".


Right now I am burning plenty of computrons and rattling the disk a
lot (let's hear it for otherwise idle machines) by exporting two
complete trees, running a slow perl script over both to remove
expansions of dollar-Id, and now dollar-Revision, make my own diff
-Nru of that, and then I guess I will have to patch by hand a zillion
annoying recent changes to the placement dollar-Id in sparc64 files.
And then I will tackle whatever I discover is still not patching after
my modified perl script finishes running.

I am starting to think that trying to run a shadow source code
controlled repository is a mistake.  Am I dragging along unadvisable
mental baggage from the old days of developing proprietary code?  Do I
need to take a deep breath here, hold my nose, have faith in The
Source, and leap??  Am I foolishly fighting Bitkeeper by trying to
stick with cvs internally?  Do I need to just give in on Bitkeeper?


Thanks,


-kb, the Kent who is coming to hate source code control system
keywords with more and more authority each day.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
