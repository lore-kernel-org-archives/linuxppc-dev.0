Date: Thu, 6 Mar 2003 13:20:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rahul Dev <rahuld@cdotd.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initrd problem: unable to read from /dev/initrd
Message-ID: <20030306202039.GB24584@ip68-0-152-218.tc.ph.cox.net>
References: <3E675B9A.1107D89@cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E675B9A.1107D89@cdotd.ernet.in>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 06, 2003 at 07:30:51AM -0700, Rahul Dev wrote:

>
> Dear all,
>
>     I m using  ads m8260 board and trying to run  linux2.5.9  over it.
[snip]
> On analyzing , i found  that the ramdisk image was loaded properly at
> 0xa00000,
> but in the function  "identify_ramdisk_image()" when i try to read the
> first block from
> /dev/initrd, i could read only  16 bytes correctly, rest all bytes are
> junk.
> Can anybody please point out why am i read  only first 16 bytes
> correctly from /dev/initrd.

Don't use 2.5.9.  If you really must have 2.5, use the current 2.5.  And
it's quite probable that you want to be using 2.4.* anyhow.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
