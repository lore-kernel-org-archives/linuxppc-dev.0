Message-ID: <3A02C77B.1F113D1@mpifr-bonn.mpg.de>
Date: Fri, 03 Nov 2000 15:11:07 +0100
From: Albrecht Dre_ <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
References: <Pine.LNX.4.10.10011031344490.9311-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> When did you last rsync? I got my latest source yesterday afternoon, and
> have no problems whatsoever...

I rsync'ed again AND compiled the kernel with the original, unmodified .config.
Again, /dev/adb could not be opened, and modprobe complains about the missing
module for char-major-56. So I am totally lost...

> You didn't accidentially delete /dev/adb?

Nope:
crw-r--r--    1 root     root      56,   0 Apr 30  1999 /dev/adb

Albrecht.


--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
