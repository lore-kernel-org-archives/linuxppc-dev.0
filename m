Date: Tue, 6 Jun 2000 21:58:09 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: daenzerm@student.ethz.ch
cc: Sinan Gürkan <sgurkan@superonline.com>,
        linux-apus-user@lists.sourceforge.net, linux-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: New experimental X 4.0 not working
In-Reply-To: <393D0D62.8D0979E2@relog.ch>
Message-ID: <Pine.LNX.4.10.10006062156360.1984-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > I installed XFree4.0b...but it doesn`t work...
> > after startx command it loads a bit and it freezes the whole system.
> > You have to reboot and filesystem is corrupted..(I ran fsck 3 times :) )
>
> Do you use update/bdflush/whatever? I get lotsa lockups when hacking kernels
> and X servers, but I've never had to run fsck more than twice (once
> automatically and once manually).

I had a case where such a freeze hosed various things on my root and usr
partitions. That was during the XFree 4.0 PCI resources trouble hacking.
Is the machine in question one with Mach64 graphics?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
