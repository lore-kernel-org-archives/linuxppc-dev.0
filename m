Message-ID: <38798CFE.1CED24AB@jlc.net>
Date: Mon, 10 Jan 2000 02:40:46 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Mark Vojkovich <mvojkovich@varesearch.com>
CC: XFree86 Devel <devel@XFree86.Org>,
        Shuangjun Zhu <r44089@email.sps.mot.com>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Question about the video device driver
References: <Pine.LNX.4.04.10001070959040.28797-100000@silicon.su.valinux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I guess I must have been sleeping when this went around the first time.....


> > On Fri, 7 Jan 2000, Shuangjun Zhu wrote:
> > > The video of MPC823 FADS board only support YCbYCr mode,


Really?  Why is that?  The 823 supports an 8-bit index into a 12-bit
colormap for LCD panels.  Why wouldn't the FADS support this?

Yes, it also supports RGB, and CCIR-601 (4:4:4 and 4:2:2) with NTSC/PAL
resolution through the CCIR-656 port.  It seems the LCD panel would
be easier to support with X......and if you are really working on
that, let me know :-).



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
