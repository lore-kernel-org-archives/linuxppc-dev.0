Subject: Re: fail to disable MMU on ppc 8241
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: llee <llee@huawei.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <40834DC0.2030408@huawei.com>
References: <40834DC0.2030408@huawei.com>
Content-Type: text/plain
Message-Id: <1082352050.1689.9.camel@gaston>
Mime-Version: 1.0
Date: Mon, 19 Apr 2004 15:20:51 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2004-04-19 at 13:55, llee wrote:
> Hi, there,
> I boot linux (2.6.3) on my ppc 8241 through vxworks bootloader. I'd got
> a port (on address 0x70020006) to constrol three LEDs, so I could know
> where the kernel going. But after the disable_mmu is called, I lost
> control to the LEDs, Any suggestion on this? As I know, vxworks use a
> one-to-one mapping MMU setup, I should must constrol the LEDs through
> the same address.

With mmu off, I suspect the 8241 acts as if the entire address space
was cacheable, which is a BAD THING for IOs typically.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
