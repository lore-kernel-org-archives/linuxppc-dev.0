Message-ID: <393D59E8.9656E51E@relog.ch>
Date: Tue, 06 Jun 2000 22:07:04 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Sinan Gürkan <sgurkan@superonline.com>,
        linux-apus-user@lists.sourceforge.net, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New experimental X 4.0 not working
References: <Pine.LNX.4.10.10006062156360.1984-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > > I installed XFree4.0b...but it doesn`t work...
> > > after startx command it loads a bit and it freezes the whole system.
> > > You have to reboot and filesystem is corrupted..(I ran fsck 3 times :) )
> >
> > Do you use update/bdflush/whatever? I get lotsa lockups when hacking
> > kernels and X servers, but I've never had to run fsck more than twice
> > (once automatically and once manually).
>
> I had a case where such a freeze hosed various things on my root and usr
> partitions. That was during the XFree 4.0 PCI resources trouble hacking.
> Is the machine in question one with Mach64 graphics?

No, it's an Amiga with Permedia2 and he used the wrong binary.


Michel


--
So many Christians, so few lions.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
