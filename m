In-Reply-To: <Pine.LNX.3.95.990610151742.24326A-100000@pacific.pht.com>
Date: Fri, 11 Jun 1999 14:03:21 +0200
To: Brad Midgley <brad@turbolinux.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [patch] mol quit-at-shutdown
Message-Id: <19990611140321.014311@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 10, 1999, Brad Midgley <brad@turbolinux.com> wrote:

>it appears all the mol cleanup is done in an atexit routine so i figured
>this would be safe. my only concern is that it looks like macos does a
>couple of scsi operations AFTER telling the cuda to power down. maybe i
>should set an alarm and have the alarm kill the emulator instead...?

Those are probably the cache flush commands. They can probably be safely
ignored within mol. for safety, you may want to add a delay before the
actual shutdown of the emulator, I think 1s should be fine.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
