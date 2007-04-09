Return-Path: <mamsadegh@hotmail.com>
Received: from bay0-omc2-s35.bay0.hotmail.com (bay0-omc2-s35.bay0.hotmail.com
	[65.54.246.171]) by ozlabs.org (Postfix) with ESMTP id 6C416DDF0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Apr 2007 19:04:18 +1000 (EST)
Message-ID: <BAY115-W7520824785D458FBA67FEB2590@phx.gbl>
From: Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
To: Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
Subject: Simple experiment with, ML403, running 2.6 kernel , kernel.org source 
Date: Mon, 9 Apr 2007 09:04:17 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

well, this post is mainly for beginners, may be useful for some one

at the begining I was trying to bring up the 2.6 kernel on ml403, I tested =
many different methods with almost no success
the kernel did not come up at all,

so, I decided to first bring up the simplest possible kernel, without any s=
pecial features or any drivers,=20
even this time I could'nt get succeed, the kernel always stopped at "now bo=
oting the kernel"

So, at the first step, I decided to make sure that the fpga bit file does n=
ot have any problems, I was not sure if I'm creating the edk project correc=
tly, so, I decided to use xilinx's reference design for ml403 as my bit fil=
e=20
for elf, at the first step, I used the provided elf by reference design, I =
mixed the elf and bit file to make the ace file, copied the ace file instea=
d of the ace file on ml403 card , every thing was ok, so I was making the a=
ce file correctly

now, I had to use my own elf, at the first step I used the kernel source co=
de, downloaded from source.mvista.com , making a simple config and building=
 the kernel I got the elf, I made the new ace file, and again the board cam=
e up successfully.

but for the kernel downloaded from kernel.org I had the same problem as bef=
ore, kernel did not go more than "now booting the kernel"

downloaded 2.6.20.4 kernel from kernel.org, I applied the .config file obta=
ined from mvista kernel to it. at the begining phase of make process it ask=
ed me about some additional configurations which where not present in mvist=
a source, answered no to all of them. I got the 2.6.20.4 elf and made the n=
ew ace file

kernel was now able to boot completely on ml403, using 2.6.20.4 kernel

and finally a simple question : so, there was some thing in the mvista .con=
fig file, which was not available in .config file of the original kerenl, a=
ny body knows what it is?=20

thanks.
_________________________________________________________________
News, entertainment and everything you care about at Live.com. Get it now!
http://www.live.com/getstarted.aspx=
