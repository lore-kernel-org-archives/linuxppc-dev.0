Date: Sat, 11 Sep 1999 11:47:19 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Weird problem compiling jcc
Message-Id: <19990911114719.012048@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Recently, I downloaded the various jcc Code Crusader sources and compiled
them without a problem on my R5 distribution.

Yesterday, I wanted to add Code Medic. So I untar'ed the CM archive in my
JX hierarchy (versions of other components were still the same), did a
make clean, just in case, and stared a make for all the components.

After a couple of hours, I had a new jcc, code medic, and the various
shared libs used by those compiled in ~/bin and ~/lib (which _is_ in my
library path).

Fine. However the problem is that any attempt to run either jcc or medic
will give me an error about symbol __ti21JXNamedTreeListWidget not found. 

I did check wiht objdump that this symbol _is_ present in
libjtree.xxx.so. I tried removing the various .o files of libjtree and
recompiled, just in case, but I still have the same problem.

Any clues ? Is this the sign that I have to update my linker ? I think I
still have the toolchain from the R5 CD, or eventually an updated version
from ftp.linuxppc.org if there is one in there (I don't use Frank's
2.95.x version yet). (I can't tell for sure which version I use now, I'm
on MacOS for the rest of the day).

Any clues ?


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
