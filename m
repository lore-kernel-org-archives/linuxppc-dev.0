Message-ID: <40C1A334.5010402@g-house.de>
Date: Sat, 05 Jun 2004 12:40:52 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix typo in binutils version check
References: <20040605074341.GA15279@suse.de>
In-Reply-To: <20040605074341.GA15279@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Olaf Hering wrote:
| The binutils check is bogus, it doesnt work with the just released
| binutils.

why is this check bogus then? i tried to compile a kernel with some
recent binutils which didn't pass the test - compilation failed.
H.J.Lu's binutils [1] are working quite well, the releases from redhat
[2] seem to produce these results you wrote about.

Christian.

[1] http://www.kernel.org/pub/linux/devel/binutils/
[2] ftp://sources.redhat.com/pub/binutils/releases/
- --
BOFH excuse #208:

Your mail is being routed through Germany ... and they're censoring us.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
