Date: Wed, 5 Mar 2003 10:32:20 -0800
From: Chris Zimman <chris@cryptoapps.com>
To: John Chan <john@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot and ibm boot
Message-ID: <20030305183220.GA8768@mail.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <3E663ED6.1030808@corelis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E663ED6.1030808@corelis.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 10:15:50AM -0800, John Chan wrote:
> my walnut board comes with ibm's boot "rom monitor" (and source code in
> CD). I wonder if I can load a linux kernal image (EDLK for example) from
> it? I heard that there is another boot code called u-boot. I wonder if
> anyone had use it before on Walnut? if yes, do you recommand me to use it?

Yes, the Walnut platform is well supported under U-Boot.

> I would like to add an audio PCI board in the walnut board and would
> like to configure/diagnosis the board during the boot time. IBM come
> with their ROM monitor source code but the compiler is not free (High
> C). I want to have capability to modify the rom monitor/boot loader to
> add my own diagnostic code.

U-Boot is built with a GNU toolchain which is freely available.  I'm not
sure why you'd want to configure an audio device inside of U-Boot, since
you could probably do it just as easily in Linux.  But if you really want
to for whatever reason, you could do it.

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
