Date: Mon, 9 Jul 2001 07:57:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Rugen <jprugen@earthlink.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Message-ID: <20010709075703.G825@opus.bloom.county>
References: <000701c10782$96a31e60$0401a8c0@trex> <20010708120006.D825@opus.bloom.county> <000e01c10884$e4201e60$0401a8c0@trex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000e01c10884$e4201e60$0401a8c0@trex>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jul 09, 2001 at 07:38:58AM -0700, Jeff Rugen wrote:

> I've booted 2.4.6 successfully 4 times so far -- 2 times it crashed with
> SCSI timeouts, and 2 times it hung for unknown reasons (with no oops output
> or anything).  The second time it might have been framebuffer or network
> related (I'd installed clgenfb, changed video modes, and then did 'dir' in
> an ftp session to a site with a long directory listing twice -- the second
> time it hung).

Did you do any fixes/cleanups to clgenfb?  I took a stab and trying to
re-do your PReP fixes in it a while back, but I don't think it ever got
into the main tree.

> Did anything change in regards to oops output on crashes since 2.2.x?  I'm
> not suprised that the kernel would crash/hang without producing any, but I
> thought I'd ask to make sure.

Don't think so..  Network _should_ be fine.  The tulip driver is having
issues on some chipsets as of 2.4.5, but it'll either not work or work fine.
de4x5 still works great tho.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
