Date: Thu, 19 Dec 2002 09:39:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: James Don <JDon@spacebridge.com>
Cc: "'Prakash kanthi'" <pkanthi@yahoo.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: After Uncompresseing Linux..., what's next
Message-ID: <20021219163941.GC852@opus.bloom.county>
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F66@SNCMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DB0585C9F6F9D411BE8F00D0B7896A4CC05F66@SNCMAIL>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 19, 2002 at 11:10:41AM -0500, James Don wrote:

> 2.) Veryfy you have your mem map from ppcboot matching requirements for the
> kernel i.e ram (physical=0x0, virtual=0xc0000000) and immr (phys 0xff000000
> virtual 0xff000000) ... I had my immr in ppc boot at 0x02200000 this screwed
> me for quite a while ... otherwise you have no printk ... the memory map is
> very important not to screw with some things depend on it (unless your
> careful) ...
>
> 3.) verify you SMC1 (uart) is getting proper clocking config ... i.e
> bus->brg1 and brg1 is 16 times baud rate ... otherwise you have no printk

That's all 8xx-specific isn't it 'tho?  It looks like this is a Xilinx
ML300 board, and thus a '40x'.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
