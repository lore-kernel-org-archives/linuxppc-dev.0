Message-ID: <3C960D92.37FE6EFF@mvista.com>
Date: Mon, 18 Mar 2002 10:53:54 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: [PATCH] My GT-64260 enhancements
References: <20020315170433.GA691@opus.bloom.county> <0203160821.AA28474@ivan.Harhan.ORG> <20020316151505.GA713@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> > Ditto. BTW, do you really want that 115200 thing in there? I've axed it in my
> > personal tree, but didn't include that in my posted patch to reduce the patch
> > scare factor.
>
> I'd be willing to bet $5 it's from Troy.  IMHO, 9600 is the defacto
> default rate, but Troy likes 'fast' serial consoles.

No, its from me.  The reason its 115200 is because that's what that version of DINK that
comes with it uses.  Having to set minicom to 115200, then change it to 9600 in the
middle of a boot doesn't make sense to me.
Why do what DINK does??  Because that's what comes with the board.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
