Date: Wed, 12 Apr 2000 11:55:34 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with Ethernet on PowerBook Wallstreet G3
In-Reply-To: <38F4BBFA.B3CE8273@execpc.com>
Message-ID: <Pine.LNX.3.96.1000412115310.25261G-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 12 Apr 2000, Joseph Garcia wrote:

> Initially, I was thinking that this is a bug brought on by the BMAC+, a

Nope.  The original bmac had this bug, too, as did this driver before bmac
was supported.  (Or at least the MkLinux version of this driver, which you
can compare line-for-line for grins.)


> change.  so its not that.  Anything else that could be causing it?  I
> don't remember this problem with earlier 2.2 kernels.  Anyone confirm
> this?  2.1.x maybe?

Unless there was a previous bmac driver that used different code, it is
unlikely that this ever worked right.  Especially, given that even Apple's
Darwin code says it's a hardware bug.  Two words: sun ethernet....  ;-)


David

---------------------------------------------------------------------
A logician trying to explain logic to a programmer is like a cat
trying to explain to a fish what it's like to be wet.

	-- unknown, possibly Franklin Veaux


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
