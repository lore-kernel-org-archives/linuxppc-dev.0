Date: Wed, 24 May 2000 11:18:48 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Stephan Leemburg <stephan@jvc.nl>
cc: Sergio Brandano <sb@dcs.qmw.ac.uk>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Debian pmud package available 
In-Reply-To: <B5514D3F.E6B3%stephan@jvc.nl>
Message-ID: <Pine.LNX.4.10.10005241024100.10697-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Thank's a lot for making this package. Did you manage to contact
> >> Stephan? What about the apmd patch?
>
> Yes, thanks! If you wish I can pull it to my source-tree and also distribute
> the debian package on every release...

That would make my job a lot easier. I still have some things to clean up
though (what subsection of the distribution; it's currently in base but
should rather go in admin like apmd; and the rc symlink generation)

I'll probably best leave xmouse out of the package; a tool to read the
mouse configuration via ADB on sleep and restore it on wakeup would be
nice to have instead.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
