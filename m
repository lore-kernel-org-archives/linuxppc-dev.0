Message-ID: <3BB51900.38CA7B65@mvista.com>
Date: Fri, 28 Sep 2001 19:42:40 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ramdisk: kernel panic...
References: <35C119252057D511BB9F0003476BF8A208E5CB@freexc01.smartm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Prasad, Siva" wrote:

> ...
>I thought of trying out with montavista's libraries and I built my own
>ramdisk with following files replaced in the ramdisk /lib directory. All
>these are built for 7xx processor (from CDK 1.2 CD of HHL).
> ...
>
> > > Freeing unused kernel memory: 180k init
> > > Kernel panic: Attempted to kill init!
> > >  <0>Rebooting in 180 seconds..
> >
> > The message indicates it was unable to execute the init
> > program.  Do you

I would suggest you get HHL 2.0 from our ftp site and try that.  The
easiest thing for you to try is "/bin/sash" as the shell or
"ash.static".  Just copy them in as /bin/sh.  (These do not use
libraries so you can assure they are correct.)

If that stuff comes up, then you have library issues and will have to
resolve those seperately.  (FYI I'd stay away from CDK 1.2 at this
point, it's old and there is a known path issue w/ the glibc.. i.e. it
want to live in /opt/hardhat/.../.../target/lib instead of /lib...)

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
