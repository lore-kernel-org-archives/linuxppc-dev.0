Date: Thu, 19 Dec 2002 08:46:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: After Uncompresseing Linux..., what's next
Message-ID: <20021219154644.GA852@opus.bloom.county>
References: <20021219001423.47019.qmail@web41207.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021219001423.47019.qmail@web41207.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 18, 2002 at 04:14:23PM -0800, Prakash kanthi wrote:

> I was trying to load linuxppc_2_4_devel onto my board.
> It goes through the board info read, UART init and
> Uncompressing the linux kernel. But after that, i do
> not see any messages and board hangs.
>
> Here is the UART output:
> ------------------------------------
> OS Booting...
>
> loaded at:     00400000 0060D1CC
> board data at: 00000030 00000044
> relocated to:  00405C24 00405C38
> zimage at:     00406290 004A08FF
> initrd at:     004A1000 006097CA
> avail ram:     0060E000 007F8000
>
> Linux/PPC load: console=ttyS0,9600 console=tty1 ip=on
> root=/dev/xsysace/disc0/pa
> rt3 rw
> Uncompressing Linux...done.
> Now booting the kernel
[snip]
> 2. How big a space this uncompressing process needs?
> And also how much overall memory is required for
> running linux. I just have 8MB SDRAM.

"Not too much".  And the zlib uncompress code will error out if there
are any problems (corruption, lack of memory, etc).  So if you got that
far, uncompression worked.

> 3. What is the next step in the booting process? Which
> Device (eth, pci, ide, ???) Initialization?

'???'.  Try enabling CONFIG_SERIAL_TEXT_DEBUG, as that will print out
some information prior to printk being usable.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
