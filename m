Date: Thu, 19 Apr 2001 10:57:36 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: William Blew <wblew@home.com>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	Michel Dnzer <michdaen@iiic.ethz.ch>,
	Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: XF4 (mach64) help please
In-Reply-To: <Pine.LNX.4.30.0104190844270.8844-100000@apollo.kulian.net>
Message-ID: <Pine.BSF.4.32.0104191056060.76936-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Apr 2001, William Blew wrote:

> On Thu, 19 Apr 2001, Iain Sandoe wrote:
>
> > 2/  how difficult would it be to plumb the scroll acceleration back into the
> > console driver?  (would one need access to the NDA stuff?) -- the scrolling
> > of console is a real problem in blocking sound :-/
>
> For mach64 at least, I would start by porting the CopyScreen2Screen XXA
> operation into the kernel and then using it during scrolling.

This is already done by atyfb in the kernel, however the problem lies in
the entire fbcon layer where there is some improper locking/interrupts
going on there.  This was discussed here and on linux-fbdev a few months
ago and I believe will be addressed in 2.5.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
