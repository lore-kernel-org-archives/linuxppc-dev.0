Message-ID: <38820AB3.72DDCF9F@wanadoo.fr>
Date: Sun, 16 Jan 2000 19:15:15 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Jan Nieuwenhuizen <janneke@gnu.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Cutting edge moved or shifting to .deb?
References: <200001161644.RAA14656@appel.flower>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jan Nieuwenhuizen wrote:
> 
> Hi List,
> 
> Can someone provide us with a list of repositories for cutting edge
> .rpm packages?  dev.linuxppc.org should be devel.linuxppc.org, but
> apart from Franz Sirl's regular glibc/binutils/gcc/rpm updates (grand!),
> not much seems to happen anymore since last September.  There's an
> almost-M12 mozilla, that crashes when I type in an url.  Then, there's
> some odd stuff in contrib and updates at ftp.linuxppc.org.

There is some pretty interesting recent stuff in contrib, but have you
ever thought about contributing yourself? The current versions of gcc
and glibc 
are so stable that you can basically take the latest *.src.rpms or even 
tgzs from anywhere and compile them with only minor tweaking.
 
> On the other hand, ftp.<cc>.debian.org has stuff such as XFree 3.3.6,
> emacs-20.5 (which is good, I was having a lot of trouble with my 20.3

ftp.mklinux.org has new RPMS, for example emacs-20.5 RPMS. The latest
xemacs versions (both stable and devel) also exist as RPMS or are easily
compilable.

And then it looks like a major new release from linuxppc.com is
imminent...

> emacs), a recent mozilla-M12, that can be alienised, but the glibc seems
> to be 'stuck' at libc6_2.1.2-5.deb.
> 
> Kernel development seems to have moved from vger to openprojects to
> Paul's at linuxcare: rsync -auvz linuxcare.com.au::linux-pmac-devel.

Vger is quite alive in recent days. I have their kernel versions
2.2.15-pre2
and 2.3.40 (pre something), both running OK for me.

Considering that this is such a small community and that there is quite
a lot of competition of LinuxPPC and MkLinux, YDL and imaclinux,
turbolinux, debian, SuSE (far too much for my taste), I think the amount
of development coming out of it is rather awesome. 

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
