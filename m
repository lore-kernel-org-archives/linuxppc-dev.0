Date: Mon, 16 Jul 2001 20:38:17 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Larry McVoy <lm@bitmover.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel ftp ?
In-Reply-To: <20010716111241.M29668@work.bitmover.com>
Message-ID: <Pine.LNX.4.10.10107162014480.20269-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Yep, but does the bitmover sire offer rsync access? That's what most of us
> > still use ...
>
> No, we do not and will not offer rsync or FTP access.  Those are very
> bandwidth intensive services, BK uses a tiny fraction of what they use,
> and you can accomplish the same thing with a
>
> 	rm -rf /tmp/exported_tree
> 	bk pull
> 	bk export -tplain /tmp/exported_tree
>
> That's way, way, way less bytes moved to get you a perfect mirror.

Thanks. I wasn't pushing for bitmover to set up rsync, I honestly didn't
remember.

> I can easily understand you not wanting to learn a new tool, or having
> some other reason, valid or otherwise, not to use BK.  That's fine.

Thanks for your understanding - in my case it's just inertia at work. Plus
there doesn't seem to be a Debian or RPM package I could find. I don't
follow kernel development closely, I don't need to commit patches, even a
source tarball snapshot posted to some big FTP archive would suit me fine.

> Our way around this problem is to get you to do one "bk clone" and only
> "bk pulls" after that.  That will transfer _only_ the data which has to
> be transferred, nothing else.  Even that is a substantial amount when
> you multiply it all out by the number of people.  We'll deal with that,
> we won't deal with full copies.

Color me naive but wouldn't a second tier of bk or other sites alleviate
that? Provided they won't allow commits so syncing the repositories won't
get to be a headache? Mvista runs a bk mirror, incidentially. Other sites
willing to set one up might be found if necessary (what's the average disk
space requirement? You covered the bandwith aspect nicely...). Together
with a note on penguinppc.org and other pages advertising the kernel
source, to please use mirrors where possible?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
