Message-ID: <3FBE2E80.3080805@g-house.de>
Date: Fri, 21 Nov 2003 16:25:52 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: trini@kernel.crashing.org
Subject: Re: ppc32 lockups with 2.6
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de> <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net> <3FB2D757.1010304@g-house.de> <20031113174745.GA11560@ip68-0-152-218.tc.ph.cox.net> <3FB41A14.3040108@g-house.de> <3FBA11AC.8090408@g-house.de> <3FBA2959.80609@g-house.de>
In-Reply-To: <3FBA2959.80609@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi again (and sorry to contact you directly, Tom),

i did not make it with kgdb, but rather compiled kernels over and over
again this week. my gcc-3.3.2 won't compile on a faster i386, so
crosscompiling was not an option :-(

i went down to 2.5.56 and found that even this kernel has the same
symptoms. in short: upon using "tulip", the machine freezes, "3c59x" is
loaded, but not working. (no routing).

i went even down to 2.5.30 to find out, that this kernel is *working*!
both tulip and 3c59x get loaded and are working. i did not test long,
don't know if it will freeze after a day or so, but i think not, as the
described freezes with newer kernel occur instantly.

the thing is, 2.5.31 ist not compiling, nor is 2.5.3x, except this very
2.5.30. same config, same compiler. 2.5.30 compile over and over again,
newer kernels (2.5.31...up to 2.5.46) *do not compile*. so it's pretty
hard to find out *when* the symptoms occur, to dig into this very patch
and finally find out *why*.

i *hope* 2.5.31 or at least 2.5.32 is the bad one. i am curently looking
through the 2.5.31 patch and sorted out ppc-related stuff, to make it
compile, then shuffle a few bits back in so, that it will compile and i
hopefully get my freeze. yes, you can see that this kind of working is
rather...er..crap. but i can't do better at the moment :-(

thanks for reading,
Christian.
--
BOFH excuse #27:

radiosity depletion


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
