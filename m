From: benh@kernel.crashing.org
To: <linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	"Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: new G4 dual 1 gig is here - how to install?
Date: Thu, 14 Feb 2002 19:08:12 +0100
Message-Id: <20020214180812.8819@mailhost.mipsys.com>
In-Reply-To: <3085F5FE-2152-11D6-9FA4-0003938E434C@ivey.uwo.ca>
References: <3085F5FE-2152-11D6-9FA4-0003938E434C@ivey.uwo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi,
>
>I hooked up an 17inch CRT and the DFP flat panel to the ATI 7500.
>
>Then I tried booting linux, here are some excerpts from the dmesg log
>(hand typed)
>
>radeonfb: ref_clk = 2700, ref_div = 12, xclk = 20025 from OF
>
>ATI Radeon 7500 QW DDR SGRAM 32MB
>
>radeonfb:  DVI port no monitor connected
>                    CRT port no monitor connected
>
>So it looks like it can't detect which port to use and defaults to CRT?
>
>I will just hack the driver to force use of DVI and try to work around
>this issue so that I don't need 2 monitors connected.
>
>But Here is the interesting line that I can't figure out
>
>no framebuffer address found for
>/pci@f0000000/ATY,BlueStoneParent@10,ATY,BlueStone_B

That's just the second head, your card is dual head message
is normal.

>So it looks like there is some other ATI device in the system that I
>don't understand where or what it is.  I see both entries for this
>BlueStone thing and entries for the Radeon 7500 in the device tree.
>
>Also, interestingly enough, SOUND is out of control on this new
>machine.  A beep comes out at ear-shattering levels no matter what I
>do.  I do believe something has changed when it comes ot sound in these
>new systems.

Maybe yet another crappy tumbler setup ? Make sure you use my
latest kernel, I also started adding some 7455 support & cleaned
up the NAP/DOZE/idle thing.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
