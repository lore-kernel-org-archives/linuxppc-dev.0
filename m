Date: Wed, 24 May 2000 22:23:01 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Stephan Leemburg <stephan@jvc.nl>, Sergio Brandano <sb@dcs.qmw.ac.uk>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Debian pmud package available 
In-Reply-To: <Pine.LNX.4.10.10005241024100.10697-100000@zirkon.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10005242156160.12552-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Yes, thanks! If you wish I can pull it to my source-tree and also distribute
> > the debian package on every release...
>
> That would make my job a lot easier. I still have some things to clean up
> though (what subsection of the distribution; it's currently in base but
> should rather go in admin like apmd; and the rc symlink generation)

OK, there's a new version of the package on my FTP site, it handles the rc
symlinks itself now and has a pwrctl function added for the iBook and
Pismo models. It would be good to see how that works in practice when pmud
attempts to put the machine to sleep (due to low power). I force the
display backlight to 0 (off) and the disk to shut down (hdparm -Y) which
worked OK for me (took a few hda timeouts and such to recover from it). If
there's any other components that can be shut down from user space please
let me know (hdc would be another candidate if it's installed - is the
Pismo media bay or iBook CDROM at hdc?

I'll upload the package to unstable immediately. It won't go into potato
anymore but that shouln't be too bad. If someone on debian-powerpc
objects, please CC me, I'm not on that list yet.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
