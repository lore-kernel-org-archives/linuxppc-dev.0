Date: Sun, 8 Jul 2001 12:00:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Rugen <jprugen@earthlink.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Message-ID: <20010708120006.D825@opus.bloom.county>
References: <000701c10782$96a31e60$0401a8c0@trex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000701c10782$96a31e60$0401a8c0@trex>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 08, 2001 at 12:49:58AM -0700, Jeff Rugen wrote:

> I've finally gotten a 2.4.x kernel to boot on my Motorola Powerstack (100MHz
> 604), but I'm having two problems.  I haven't found any info about them
> searching the archives, so I'm wondering if anyone has seen/resolved the
> problems I have, or can direct me to more information.

Series E?  Got one right here, and I just booted 2_4_devel too :)

> First of all, the boot hangs when executing /sbin/hwclock.  I have (or maybe
> 'had' now) the real-time-clock built as a module (in
> drivers/macintosh/rtc.o), but the only thing I determined before commenting
> out that line in rc.sysinit was that the machine hung when reaching that
> point.  Is anyone successfully using the realtime clock on a Powerstack with
> 2.4.x, and if so, is there anything in particular that needs to be
> done/patched/whatever?  /sbin/hwclock is from util-linux-2.10m-7c.

That looks like an OK version of util-linux.  Try compiling CONFIG_RTC_PPC in
and not CONFIG_RTC.

> Second, I am getting SCSI timeouts when running 2.4.6.  I don't know enough
> about SCSI, but the log to the console is the following:

Consistant?  I saw this once when booting off the HD but not the next time.
Then I went back to NFS rooted.

> Which leads me to believe that I at least have the correct SCSI driver build
> (NCR53C8XX, as the revision of 0x2 is less than the 16 that Configure.help
> seems to indicate).  Should I instead be using the 53c7,8xx driver?  Or the
> sym53c8xx?

sym53c8xx will tell you unsupported chip.  I don't know if 53c7,8xx will work
but give it a shot, please. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
