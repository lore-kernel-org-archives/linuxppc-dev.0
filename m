Message-ID: <XFMail.20020218094253.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20020218021717.EDHQ21433.tomts12-srv.bellnexxia.net@there>
Date: Mon, 18 Feb 2002 09:42:53 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: RE: Final question: best wasy to move /, /usr, /home, etc?
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I am finally at the point I want to give up my old external scsi hard
> drives.  Unfrotunately, my current /, /usr, /home, etc all exist on scsi
> drives.
>
> I recently purchased a 60 gig hard drive (ide) and have now installed it.

IDE ?!?  Bleah !!

> What is the best way to move all of the files and directories, and special
> device files, and etc from the scsi drive to new partitions on the IDE
> drives?
>
> Can I simply use a recursive "cp" with -a?  Should I use "tar"?  What
> about "parted" and its partition copies?

cp -a works fine.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
