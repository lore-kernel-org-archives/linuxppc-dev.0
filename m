Message-ID: <3E8B0058.4030503@mvista.com>
Date: Wed, 02 Apr 2003 09:23:04 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Toni Van Remortel <t.vanremortel@ha.be>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: EP405 Kernel Panic
References: <20030402140215.47965273.t.vanremortel@ha.be>
In-Reply-To: <20030402140215.47965273.t.vanremortel@ha.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This comes up weekly on the mailing list, if you search the archives you'll find
the canned response:

Make sure you have all of the libraries required by your shell.  If there are
missing libraries it will return back no init found.

Use objdump or ldd to get a list of the required libraries.  (At the minimum you
will need /lib/ld.so and /lib/libc.so.)  Alternative is to statically link your
shell.

--Mark

> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 1771k freed
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 76k init
> Kernel panic: No init found.  Try passing init= option to kernel.
>
>
> So as you can see, the kernel parameters are root=/dev/ram
> init=/bin/bash, but why does the kernel panic on No init!?
> /bin/bash does exist in the initrd.
>
> Anybody an idea where to look?
>
> # file bin/bash
> bin/bash: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1 (SYSV), for GNU/Linux 2.2.5, dynamically linked (uses shared libs), stripped
> Needed libs are in /lib.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
