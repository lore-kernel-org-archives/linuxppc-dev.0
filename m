Date: Tue, 17 Aug 1999 13:09:17 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Mike Lambert <lambert@jeol.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Extra brightness off with the XClaim 3D Plus
In-Reply-To: <Pine.SGI.4.10.9908130946190.968-100000@davinci.jeol.com>
Message-ID: <Pine.LNX.4.10.9908171308490.25292-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Aug 1999, Mike Lambert wrote:
> On Wed, 11 Aug 1999, Rick Meier wrote:
> > On the XClaim 3D plus the extra brightness needs to be turned off or the
> > card overdrives the monitor.  Here is a patch to the kernel if anyone
> > wants to try it.
> 
> > --- atyfb.c     Wed Aug 11 13:49:29 1999
> > +++ atyfb.c.orig        Wed Aug 11 13:57:49 1999
> > @@ -3418,7 +3418,7 @@
> >      if (Gx == GT_CHIP_ID || Gx == GU_CHIP_ID || Gx == GV_CHIP_ID ||
> >         Gx == GW_CHIP_ID || Gx == GZ_CHIP_ID || Gx == LG_CHIP_ID ||
> >         Gx == GB_CHIP_ID || Gx == GD_CHIP_ID || Gx == GI_CHIP_ID ||
> > +       Gx == GP_CHIP_ID || Gx == GQ_CHIP_ID)
> >         i |= 0x2;       /*DAC_CNTL|0x2 turns off the extra brightness
> > for gt*/
> >      aty_st_8(DAC_CNTL, i, info);
> >      aty_st_8(DAC_MASK, 0xff, info);
> 
> Thanks Rick, this works as advertised. The XClaim 3D Plus in my B+W G3 400
> now works properly. Well, except for the mild snow down the left side of
> the display, but that is a different problem...

Does the B+W G3 400 really has a RAGE LT PRO? I thought that chip was meant for
laptops.

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
