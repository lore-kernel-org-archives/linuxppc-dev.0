Date: Mon, 2 Aug 1999 10:16:50 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: C&T acceleration support, needs testers.
In-Reply-To: <19990801234848Q.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.10.9908021015200.7348-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 1 Aug 1999, Ryuichi Oikawa wrote:
> From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
> Subject: C&T acceleration support, needs testers.
> > I'm trying to implement C&T 6555x HW acceleration to the X servers.
> > I put a Xpmac binary:
> >  ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/hw/powermac/Xpmac-19990731-glibc2.1.gz
> > XF68_FBDev version hasn't been compiled, yet.
>  It's just been compiled:
> ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/hw/xfree68/XF68_FBDev-19990801-glibc2.1.gz
> 
>  Because FB_ACCEL code isn't defined for C&T 65550 and it requires to accesss
> both MMIO and IO space, it scans PCI configuration space through /proc/bus/pci.
> I'm not quite sure if it can detect C&T 6555x properly (just write and compile,
> not checked, yet). I hope Geert or someone accept the patch...

The Right Way(TM) to make XF68_FBDev detect a C&T 65550 is to request one or
more FB_ACCEL_* IDs from me.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
