Date: Thu, 13 Dec 2001 09:13:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Rugen <jprugen@earthlink.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
Message-ID: <20011213161314.GF28967@cpe-24-221-152-185.az.sprintbbd.net>
References: <000701c10782$96a31e60$0401a8c0@trex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000701c10782$96a31e60$0401a8c0@trex>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 08, 2001 at 12:49:58AM -0700, Jeff Rugen wrote:

> Second, I am getting SCSI timeouts when running 2.4.6.  I don't know enough
> about SCSI, but the log to the console is the following:
>

Boy, I hope you're still around to play with things :)
Can you try the sym-2 driver in recent (2.4.16+ kernels?).  I've been
doing some quick testing of my machine, and things seem OK so far.

> Which leads me to believe that I at least have the correct SCSI driver build
> (NCR53C8XX, as the revision of 0x2 is less than the 16 that Configure.help
> seems to indicate).  Should I instead be using the 53c7,8xx driver?  Or the
> sym53c8xx?

BTW, the sym53c8xx driver won't do the 810 or 825 chipsets, iirc.  The
53c7,8xx driver needs a bit of work (it's still got an hold hack for PPC
that I _think_ can just go, but I'm not sure...).  The sym-2 driver does
all 8xx chipsets and some of the newer 10xx chipsets.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
