Date: Mon, 15 Apr 2002 11:54:42 -0500
From: Troy Benjegerdes <hozer@drgw.net>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Incoming to helium.harhan.org:/home/linuxppc/linuxppc_2_4_alt
Message-ID: <20020415115442.J6003@altus.drgw.net>
References: <0204091923.AA23957@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0204091923.AA23957@ivan.Harhan.ORG>; from msokolov@ivan.Harhan.ORG on Tue, Apr 09, 2002 at 12:23:57PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 09, 2002 at 12:23:57PM -0700, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Well, take a look at what the file used to look like in _devel.  It was
> > around 30-40 lines of that.  Which is not nice to look at.
>
> So what's more important, a pretty look or better functionality for the user?

Above all, *readable* code, because otherwise someone changes something,
and inadvertently breaks machines that they don't have to test on.

Which then results in a crappy user experience because the same config
they are used to useing doesn't work anymore on the latest 'stable'
kernel.

This *still* happens a lot for my MTX, but it's gotten a lot better
over time.

If better functionality for the user is your goal, you can't achieve it by
designing code around that goal. (Unless, of course, you're Apple computer
and have large resources for QA and testing, and design the hardware
yourself)

--
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's
why I draw cartoons. It's my life." -- Charles Schulz

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
