Date: Thu, 26 Aug 1999 10:40:46 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
        Debian GNU/Linux PPC <debian-powerpc@lists.debian.org>,
        recipient list not shown: ;
Subject: Re: Bugs in xfree68 that made it fail with jdk 1.2.1 found and fixed
 (fwd)
In-Reply-To: <Pine.LNX.4.10.9908192004590.4521-100000@idd-01.imbc.gr>
Message-ID: <Pine.LNX.4.10.9908251112090.23842-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Aug 1999, Kostas Gewrgiou wrote:
> On Thu, 19 Aug 1999, Geert Uytterhoeven wrote:
> > On Tue, 17 Aug 1999, Kostas Gewrgiou wrote:
> > > On Tue, 17 Aug 1999, Geert Uytterhoeven wrote:
> > > > Anybody who'd care to try? I just erased my XFree86 3.3.x tree.
> > > > 
> > > > BTW, I'm always willing to test a glibc-2.1 binary :-)
> > > >
> > > 
> > >  I had to erase my build of 3.9.15x to make space for the 3.3.x build *sigh* :(
> > > I'll have a binary in a few hours if you are intrested (Builds take a looong
> > > time in my 604@132). I have to see if i can fix the no video drivers and the
> > > Modes "default" case first (and write a cleaner patch ;).
> > 
> > I'm interested for sure!
> 
>   Test binary at ftp://idd-01.imbc.gr/pub/XF68_FBDev.bz2 
> depth 15 works (requires a Depth 15 entry in XF68Config) 
> the XFree86-VidModeExtension is also working same with xvidtune..

The X server works, but I indeed need a depth 15 entry in XF86Config, or I get
a SEGV. Can this be fixed, so it doesn't give SEGV, but perhaps a normal error
message? At first I though it didn't work, then I read about the depth 15.

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
