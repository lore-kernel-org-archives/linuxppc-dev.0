Message-ID: <3A02B060.4C470BFB@mpifr-bonn.mpg.de>
Date: Fri, 03 Nov 2000 13:32:32 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
References: <Pine.LNX.4.10.10011031315320.2558-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> Make sure you the core adb support is compiled in. It currently is, unless
> CONFIG_MBX is set ... if CONFIG_ALL_PPC=y implies CONFIG_MBX=y, someone
> better fix this.

from .config:
# CONFIG_MBX is not set

> Did all your kernels that crash lack ADB support, or just the latest you
> built with CONFIG_ALL_PPC=y ?

Just the latest rsync'ed linux-pmac-stable from penguinppc.org. Before, I always
used Ben's (rsync'ed) kernels, and configured them for PowerMac's only. No
problems with starting pmud. Now, both configuring for PowerMac only and for
ALL_PPC have no /dev/adb. I'm afraid I have to dig into the sources...SIGH!

Thanks, Albrecht.

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
