Message-ID: <39AF9699.5529818B@student.ethz.ch>
Date: Fri, 01 Sep 2000 13:44:25 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: "Timothy A. Seufert" <tas@mindspring.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: asm statement in include/asm not ansi conform
References: <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>
	 <39AE8559.A4F12B6D@relog.ch> <v04220804b5d51c963eff@[10.0.0.42]>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Timothy A. Seufert" wrote:

> (II) r128(0): PLL parameters: rf=18432 rd=45949 min=-2143223788
> max=2088639352; xclk=0
> (==) r128(0): Using gamma correction (1.0, 1.0, 1.0)
> (II) r128(0): Monitor0: Using hsync range of  30.00- 95.00 kHz
> (II) r128(0): Monitor0: Using vrefresh range of  48.00-160.00 Hz
> (II) r128(0): Clock range: -2143223.79 to -588442.96 MHz

The PLL and clock values are bogus. You could try overriding the clock values
in XF86Config.


> For comparison, this is what I get with a mainline 4.0.1 tree with
> Ani Joshi's replacement drivers for PPC (no DRI support of course):

[snip]

> I have checked out a copy of the PPC branch of the DRI CVS tree, so
> if you need me to test with different things just let me know.

Just putting Ani's r128 (or the whole xfree86) directory into the DRI tree
should work, as the changes in the DRI branch are mostly outside the 2D
driver. Please let me know if there are problems.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
