Date: Sun, 17 Feb 2002 19:12:04 -0800 (PST)
From: "Jeramy B. Smith" <jeramy@penguinppc.org>
To: "Kevin B.Hendricks" <khendricks@ivey.uwo.ca>
Cc: yellowdog-devel@lists.yellowdoglinux.com,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Final question: best wasy to move /, /usr, /home, etc?
In-Reply-To: <20020218021717.EDHQ21433.tomts12-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.44.0202171911480.11448-100000@ash.penguinppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


http://www-106.ibm.com/developerworks/library/partplan.html

There is the IBM way.

On Sun, 17 Feb 2002, Kevin B.Hendricks wrote:

> Hi,
>
> I am finally at the point I want to give up my old external scsi hard
> drives.  Unfrotunately, my current /, /usr, /home, etc all exist on scsi
> drives.
>
> I recently purchased a 60 gig hard drive (ide) and have now installed it.
>
> What is the best way to move all of the files and directories, and special
> device files, and etc from the scsi drive to new partitions on the IDE
> drives?
>
> Can I simply use a recursive "cp" with -a?  Should I use "tar"?  What
> about "parted" and its partition copies?
>
> Or is there some way I can run an linux distribution installer from within
> linux and make it install to the ide drive instead of the scsi?
>
> Or is there some way to make "rpm" nicely redirect where it installs
> things?
>
>
> In fact, with som much space, I would love to have Debian, SuSE, and
> YellowDog distribution sets so I can run and test OpenOffice.org against
> those distributions easily (shared build drives) with different
> distribution installations.
>
> This is my last step to get a working system so any hints on the best way
> to move so much data (and special device files) from one partition to
> another preserving the owner,group,word, permissions, file ownership,
> setuid root bits, etc. would be greatly appreciated.
>
> Thanks,
>
> Kevin
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
