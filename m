Date: Sat, 5 Jun 2004 13:11:35 +0200
From: Olaf Hering <olh@suse.de>
To: Christian Kujau <evil@g-house.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix typo in binutils version check
Message-ID: <20040605111135.GA30640@suse.de>
References: <20040605074341.GA15279@suse.de> <40C1A334.5010402@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <40C1A334.5010402@g-house.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 On Sat, Jun 05, Christian Kujau wrote:

>
> Olaf Hering wrote:
> | The binutils check is bogus, it doesnt work with the just released
> | binutils.
>
> why is this check bogus then? i tried to compile a kernel with some
> recent binutils which didn't pass the test - compilation failed.
> H.J.Lu's binutils [1] are working quite well, the releases from redhat
> [2] seem to produce these results you wrote about.

The checkbin target fails with current binutils cvs, you need an
additional option like -many

--
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
