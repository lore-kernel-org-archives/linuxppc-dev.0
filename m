Date: Wed, 15 Mar 2000 21:18:33 -0500 (EST)
From: "Peter M. Jansson" <petej@clickvision.com>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SIGALRM can't be delivered after longjmp from handler?
In-Reply-To: <Pine.LNX.3.96.1000315180936.32684F-100000@deepspace.mklinux.org>
Message-ID: <Pine.LNX.4.10.10003152117340.9912-100000@penguin.office.clickvision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


OK...I just tried this with setting the second parameter of sigsetjmp to
1, instead of leaving it at 0.  I need to RTFM more to understand why it
made a difference, but at least it works.

Thanks all!

Pete.

On Wed, 15 Mar 2000, David A. Gatwood wrote:

> *ponders*....  Try sigsetjmp and siglongjmp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
