Message-Id: <v03110701b4eda44b28b7@[129.100.29.243]>
In-Reply-To: <20000309201738.011546@mailhost.mipsys.com>
References: <v03110700b4ed3e1295ce@[129.100.29.243]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 9 Mar 2000 14:01:38 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: IDE problems with 2.3.49?- same with 2.2.15pre3
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

>>Is there something different about recent G4 450s that I need to worry about?
>
>Use yaboot, not BootX and tell me if you still have the problem.

I grabbed the yellowdog yaboot_0.4 (I can not get your yaboot_0.5 to
uncompress properly) and started up with with the following yaboot.conf

image=zip:vmlinux.2.2.15pre3
label=linuxppc
append="root=/dev/hda12 video=aty128fb:vmode:18,cmode:32"

And used the command-option-o-f settings to get the of prompt and then typed:

boot zip:yaboot_0.4

and at the yaboot prompt typed linuxppc

Unfortunately I could not see the screen since it got split into 3 separate
vertical panes (like the aty128fb.c problem that anthony fixed by removing
the clock setting calls if you remember).

I will try again with just the OF frame buffer and let you know what if any
error messages about lost interrupts come up.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
