Message-ID: <392D16CA.793F5C4C@student.ethz.ch>
Date: Thu, 25 May 2000 14:04:26 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Stephan Leemburg <stephan@jvc.nl>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Debian pmud package available
References: <Pine.LNX.4.10.10005242156160.12552-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> OK, there's a new version of the package on my FTP site, it handles the rc
> symlinks itself now and has a pwrctl function added for the iBook and
> Pismo models.

Thanks, will test it.


> It would be good to see how that works in practice when pmud attempts to put
> the machine to sleep (due to low power).

When I tried to run snooze with the old version, it said 'function not
implemented' or similar - is this related?


> is the Pismo media bay or iBook CDROM at hdc?

The DVD-ROM in my Pismo is hde.


Michel


--
Here I am! Now what are your other two wishes?
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
