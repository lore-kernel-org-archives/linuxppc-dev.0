Message-ID: <3E011C4B.F957E650@wvi.com>
Date: Wed, 18 Dec 2002 17:09:31 -0800
From: Jim Potter <jrp@wvi.com>
Reply-To: jpotter@dualg4.com
MIME-Version: 1.0
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: After Uncompresseing Linux..., what's next
References: <20021219001423.47019.qmail@web41207.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What hardware are you booting?
What bootloader are you using (PPCboot, DINK, etc)?

Do you have a BDI2000 -- you could look at the target memory to see what's
happening.  Alternatively, you could throw in some print statements dumping
the target memory before jumping to it.  Also some print statements to show
what's happening when you're uncompressing the kernel might be helpful.

You might want to have a look at your caches, making sure they're flushed
(etc).


> Hi there,
>
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
> -------------------------------------------
>
> After the last line, it hangs. I get a feeling that,
> the uncompressing process is not writing in the memory
> starting from 0x00000000 and, after uncompressing, it
> is jumping into 0x00000000 and is not able to find
> anything.
>
> My questions are,
> 1. How can i make sure that, the uncompressing process
> is going to start writing the data from 0x00000000.
>
> 2. How big a space this uncompressing process needs?
> And also how much overall memory is required for
> running linux. I just have 8MB SDRAM.
>
> 3. What is the next step in the booting process? Which
> Device (eth, pci, ide, ???) Initialization?
>
> Your help is appreciated.
>
> thanks,
> Prakash
>

--
Sincerely,

Jim Potter
45th Parallel Processing

  Firefighting: Bustin' ours, Savin' yours.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
