Date: Wed, 8 Mar 2000 14:26:53 -0600
From: jrosenau@midway.uchicago.edu
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: AltiVec on Linux
Message-ID: <20000308142652.I5723@midway.uchicago.edu>
Reply-To: jrosenau@midway.uchicago.edu
References: <v04011708b4ec4b0ae554@[129.116.196.236]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04011708b4ec4b0ae554@[129.116.196.236]>; from gallen@arlut.utexas.edu on Wed, Mar 08, 2000 at 12:59:29PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So on Wed, Mar 08, 2000 at 12:59:29PM -0600, Greg Allen was all like,

>Unfortunately, powerpc-eabisim-g++ doesn't recognize "vector" at all.
>That's right, boys and girls, NO C++ SUPPORT WITH ALTIVEC!
>
>So we have to patch g++ the same way gcc was patched -- to extend the C++
>language for AltiVec.

But vector is already a type in the STL, so it can't be supported in g++
without breaking that.  I guess you could overload all sorts of neat
stuff, but it really does sound like a hack.  Why not create a standard
library that would handle MMX, 3Dnow!, Altivec, whatever?  If there's a
standard interface to those, we should encourage Motorola to make
altivec work the same way.

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
