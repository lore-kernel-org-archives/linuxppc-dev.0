Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: yellowdog-devel@lists.yellowdoglinux.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Final question: best wasy to move /, /usr, /home, etc?
Date: Sun, 17 Feb 2002 21:17:05 -0500
References: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca> <p05101401b895b9cbee49@[10.0.0.42]> <20020217203742.VCID12383.tomts9-srv.bellnexxia.net@there>
In-Reply-To: <20020217203742.VCID12383.tomts9-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20020218021717.EDHQ21433.tomts12-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am finally at the point I want to give up my old external scsi hard
drives.  Unfrotunately, my current /, /usr, /home, etc all exist on scsi
drives.

I recently purchased a 60 gig hard drive (ide) and have now installed it.

What is the best way to move all of the files and directories, and special
device files, and etc from the scsi drive to new partitions on the IDE
drives?

Can I simply use a recursive "cp" with -a?  Should I use "tar"?  What
about "parted" and its partition copies?

Or is there some way I can run an linux distribution installer from within
linux and make it install to the ide drive instead of the scsi?

Or is there some way to make "rpm" nicely redirect where it installs
things?


In fact, with som much space, I would love to have Debian, SuSE, and
YellowDog distribution sets so I can run and test OpenOffice.org against
those distributions easily (shared build drives) with different
distribution installations.

This is my last step to get a working system so any hints on the best way
to move so much data (and special device files) from one partition to
another preserving the owner,group,word, permissions, file ownership,
setuid root bits, etc. would be greatly appreciated.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
