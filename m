Date: Mon, 19 Apr 2004 11:55:44 +0800
From: llee <llee@huawei.com>
Subject: fail to disable MMU on ppc 8241
To: linuxppc-dev@lists.linuxppc.org
Message-id: <40834DC0.2030408@huawei.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, there,
I boot linux (2.6.3) on my ppc 8241 through vxworks bootloader. I'd got
a port (on address 0x70020006) to constrol three LEDs, so I could know
where the kernel going. But after the disable_mmu is called, I lost
control to the LEDs, Any suggestion on this? As I know, vxworks use a
one-to-one mapping MMU setup, I should must constrol the LEDs through
the same address.

Thanks for any suggestion.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
