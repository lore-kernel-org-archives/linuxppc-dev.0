Date: Mon, 17 Jan 2000 22:05:25 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Argh, PReP netbooting doesn't use residual data
Message-ID: <Pine.LNX.4.10.10001172159080.20769-100000@altus.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Is there any sane way to fix arch/ppc/boot/misc.c so that PReP machines
that are network booting can figure out how much memory the machine has?

I have a MVME 2600 with 16 MB of RAM I have been fighting with the last
week until I realized it assumed 32 MB while the machine only had 16, and
*did not* print a warning message of any sorts.

Gabriel Paubert has done quite a bit of work on his prep bootloader.. Are
there some reasons that this bootloader could not be included as a config
option?

Thanks

--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
