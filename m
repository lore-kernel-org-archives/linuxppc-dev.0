From: bharat <bharat@coraltele.com>
To: "Georg Klug" <gklug@giga-stream.de>
Subject: Re: regarding kernel access of bad area
Date: Tue, 15 Jun 2004 17:01:02 +0530
References: <FFECLICFNBJAHONLGAKMAEBIDEAA.gklug@giga-stream.de>
In-Reply-To: <FFECLICFNBJAHONLGAKMAEBIDEAA.gklug@giga-stream.de>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;  charset="utf-8"
Message-Id: <200406151701.02638.bharat@coraltele.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi georg
thanks for answering
but i could not understand which initialization u are talking about whether it
is of UPM machine or it is something else if it is regarding that UPM machine
then it is ok as other code is also using the same upm machine settings and
running ok
please put some light on it.
bharat

On Tuesday 15 June 2004 02:08 pm, you wrote:
>
> Most likely your SDRAM initialization is corrupt. How do you do the
> hardware initialization if you don't use a boot loader? The U-Boot
> project is a good example of the work what needs to be done BEFORE
> loading the Linux kernel.
>
> > -----Ursprungliche Nachricht-----
> > Von: bharat
> > Gesendet: Dienstag, 15. Juni 2004 07:35
> > Betreff: regarding kernel access of bad area
> >
> >                    i am trying to port hardhat linux for our
> > custome hardware i donot use a bootloader instead i used
> > uncompressed(vmlinux) image and a self made utility which download
> > the kernel into the ram and transfer the control to it kernel gets
> > executed and mount the NFS file system from my host as soon as it
> > tries to execute the /sbin/init or /bin/init or any other user
> > program init it gives the following error Kernel panic: kernel
> > access of bad area pc c0014198 lr 1 addr ess FFFFB104 tsk swapper/0
> > In swapper task - not syncing

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
