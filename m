Date: Thu, 19 Apr 2001 08:46:25 -0700 (PDT)
From: William Blew <wblew@home.com>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>,
	Michel Dnzer <michdaen@iiic.ethz.ch>,
	Kaoru Fukui <k_fukui@highway.ne.jp>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: XF4 (mach64) help please
In-Reply-To: <20010419123638.58C8ADB9E7@atlas.valhalla.net>
Message-ID: <Pine.LNX.4.30.0104190844270.8844-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Apr 2001, Iain Sandoe wrote:

> 2/  how difficult would it be to plumb the scroll acceleration back into the
> console driver?  (would one need access to the NDA stuff?) -- the scrolling
> of console is a real problem in blocking sound :-/

For mach64 at least, I would start by porting the CopyScreen2Screen XXA
operation into the kernel and then using it during scrolling.

This would involve both a port of the operation itself and of the setup of
the mach64 2D engine as per the ati driver.
--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
