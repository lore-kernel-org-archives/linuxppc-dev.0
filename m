Date: Mon, 22 Jan 2001 09:11:35 +1100
From: Steven Hanley <sjh@svana.org>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [patch] missing exported symbols
Message-ID: <20010122091135.A19788@chiru.svana.org>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <20010121144057.A27643@wibble.net> <20010121142823.B6223@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010121142823.B6223@opus.bloom.county>; from trini@kernel.crashing.org on Sun, Jan 21, 2001 at 02:28:23PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 21, 2001 at 02:28:23PM -0700, Tom Rini wrote:
> On Sun, Jan 21, 2001 at 02:40:57PM +1100, Steven Hanley wrote:
>
> > The first one I am pretty sure belongs in this file as i have noticed a few
> > other archs have to export it here.
>
> Err, what needs this symbol tho?  And are you sure this is actually needed?
> I'm about to re-do my modtest config vs 2.4.1pre9, but as of ~2.4.0 release
> or an early 2.4.1 the bk tree was fine wrt modules now..  And, as of 2.4.1pre9
> only sh exports flush_dcache_page, and sparc64 exports __flush_dcache_page,
> so are you sure this is needed?

smbfs and nfs modules, I need nfsa, I notice it works fine in 2.4.0 on i386,
jiust it has not worked for more than a month in the 2.4) type kernels on
ppc.

> > The gmac one i am unsure if this is the best place to put the export, but it
> > works so I put it here.
>
> This has been fixed in the 2_4 bk for atleast a week, and 2_5 for much longer.

Was that the correct place to export it?

I tend to run paulus kernels, probably mostly because I have rsync or cvs
available, have not played with bk yet (though I am su re it is easy) and
also that I tend to be able to go speak with paulus in person or such if I
want to ask him stuff or some such.

	See You
	    Steve

--
sjh@wibble.net http://wibble.net/~sjh
Look Up In The Sky
    Is it a bird?   No
        Is it a plane    No
            Is it a small blue banana?
Yes

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
