Date: Thu, 14 Feb 2002 08:53:13 -0500
Subject: Re: new G4 dual 1 gig is here - how to install?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v480)
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
In-Reply-To: <D232876A-2024-11D6-A30D-0003938E434C@ivey.uwo.ca>
Message-Id: <3085F5FE-2152-11D6-9FA4-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I hooked up an 17inch CRT and the DFP flat panel to the ATI 7500.

Then I tried booting linux, here are some excerpts from the dmesg log
(hand typed)

radeonfb: ref_clk = 2700, ref_div = 12, xclk = 20025 from OF

ATI Radeon 7500 QW DDR SGRAM 32MB

radeonfb:  DVI port no monitor connected
                    CRT port no monitor connected

So it looks like it can't detect which port to use and defaults to CRT?

I will just hack the driver to force use of DVI and try to work around
this issue so that I don't need 2 monitors connected.

But Here is the interesting line that I can't figure out

no framebuffer address found for
/pci@f0000000/ATY,BlueStoneParent@10,ATY,BlueStone_B

So it looks like there is some other ATI device in the system that I
don't understand where or what it is.  I see both entries for this
BlueStone thing and entries for the Radeon 7500 in the device tree.

Also, interestingly enough, SOUND is out of control on this new
machine.  A beep comes out at ear-shattering levels no matter what I
do.  I do believe something has changed when it comes ot sound in these
new systems.

I will try to dump the OF device tree and get the dmesg log posted so
that anyone interested can take a look at things to look for interesting
items.

So I am progressing ....

Anything anyone wants me to dump, just let me know and I will try to
provide the info they need.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
