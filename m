Message-ID: <37DA744E.3A3AFEC7@pop.agri.ch>
Date: Sat, 11 Sep 1999 17:25:06 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Weird problem compiling jcc
References: <19990911114719.012048@smtp.calvacom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,


Benjamin Herrenschmidt wrote:
> 
> Recently, I downloaded the various jcc Code Crusader sources and compiled
> them without a problem on my R5 distribution.
> 
> Yesterday, I wanted to add Code Medic. So I untar'ed the CM archive in my
> JX hierarchy (versions of other components were still the same), did a
> make clean, just in case, and stared a make for all the components.
> 
> After a couple of hours, I had a new jcc, code medic, and the various
> shared libs used by those compiled in ~/bin and ~/lib (which _is_ in my
> library path).
> 
> Fine. However the problem is that any attempt to run either jcc or medic
> will give me an error about symbol __ti21JXNamedTreeListWidget not found.
> 
> I did check wiht objdump that this symbol _is_ present in
> libjtree.xxx.so. I tried removing the various .o files of libjtree and
> recompiled, just in case, but I still have the same problem.
> 
> Any clues ? Is this the sign that I have to update my linker ? I think I
> still have the toolchain from the R5 CD, or eventually an updated version
> from ftp.linuxppc.org if there is one in there (I don't use Frank's
> 2.95.x version yet). (I can't tell for sure which version I use now, I'm
> on MacOS for the rest of the day).

I've lot of experiences in building JCC & co did it x-times...
My experiences led me to the approach to reinstall EVERY thing of JX
including medic and it's components. ( When something is new)
I cleaned my /usr/lib from all JX components. I opened and exported my
private lib directory.

Also I added the uncomment of J_DIE_ON_WARNINGS
and the compiler switch -fpermissive, if this is really necessary??? (gcc-2.95.X)

After unpacking all I sent a make linuxppc5 and all went through without
any problems. CC worked and Medic too. 

Shortly I had a mail discussion with a guy here from Zurich about
building JCC (only cc) and at first he wasn't able to get it to work.
Later he reported that he had to remove the built makemake etc. So my
guess would be: rm -r JX-1* and unpacking the whole stuff again
including the build process. 
BTW on PBG3 250 it doesn't take hourS only about an hour...

This I did on various machines from standard LinuxPPC5 (CD) up to latest
2.95.1 glibc2.1.2.... no worry all builds worked.

It's working ...

Regards
Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
