From: "Rob Taylor" <robt@flyingpig.com>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: kernel executing from flash
Date: Fri, 24 Mar 2000 09:54:18 -0000
Message-ID: <000501bf9576$ebd7ef20$b400a8c0@eventhorizon>
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
In-Reply-To: <200003232005.VAA05535@denx.local.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In message
> <1314024740.953824470340.JavaMail.wwwrun@moe.freenet.de> you wrote:
> >
> > all Linux I know will be copied during startup from Harddisk,
> NFS or Flash to RAM and will be executed there.
> > Is there a possibility for smaller systems to run the
> > kernel directly from flash memory as other embedded os's do?
> Did somebody try this or is it totaly impossible?
>
> It may be possible, but usually it does not make much sense - to  run
> the  kernel directly from FLASH you must store an uncompressed kernel
> image there, so you need  more  FLASH.  Given  the  price  difference
> between  FLASH  and  DRAM  memory is often cheaper to uncompress into
> RAM, and run from RAM.
>
not to mention that DRAM is usually faster than FLASH...

Rob

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
