Date: Wed, 5 Mar 2003 11:30:21 -0700
From: Matt Porter <porter@cox.net>
To: John Chan <john@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot and ibm boot
Message-ID: <20030305113021.A4610@home.com>
References: <3E663ED6.1030808@corelis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E663ED6.1030808@corelis.com>; from john@corelis.com on Wed, Mar 05, 2003 at 10:15:50AM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 10:15:50AM -0800, John Chan wrote:
>
> Hello, folks,
>
> my walnut board comes with ibm's boot "rom monitor" (and source code in
> CD). I wonder if I can load a linux kernal image (EDLK for example) from
> it? I heard that there is another boot code called u-boot. I wonder if
> anyone had use it before on Walnut? if yes, do you recommand me to use it?
>
> I would like to add an audio PCI board in the walnut board and would

SB Live works well, use the linuxppc_2_4_devel tree.

> like to configure/diagnosis the board during the boot time. IBM come
> with their ROM monitor source code but the compiler is not free (High
> C). I want to have capability to modify the rom monitor/boot loader to
> add my own diagnostic code.

Use u-boot, that will give you the flexibility you need.

--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
