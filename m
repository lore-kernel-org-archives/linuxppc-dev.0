Message-ID: <382DB44C.37F36FA6@wanadoo.fr>
Date: Sat, 13 Nov 1999 19:56:12 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: happyoscar42@usa.net
CC: LinuxPPC-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: vger 2.3.18
References: <382D7B07.A3FEE944@usa.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Riley wrote:
> 
> Is there a particular config option I should avoid on the current vger
> 2.3.18 kernel?  It doesn't boot past the early bootx boot text.

You can get it to boot if you check out a version of September 12 or
earlier. After that, it seems to me that PPC support has been dropped at
vger (or at least at its cvs.on.openprojects mirror). If you want a
later 2.3.xx kernel that boots and runs OK, get Paul Mackerras'
pmac-devel kernel by rsync. It is at 2.3.22, but anything later looks
pretty dangerous to me, and the recent (2.3.26 or later) kernel.org
kernels don't boot.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
