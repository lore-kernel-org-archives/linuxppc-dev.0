Date: Wed, 30 Aug 2000 17:45:02 -0700
From: Matt Porter <mporter@mvista.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Message-ID: <20000830174502.A3868@cx258813-a.chnd1.az.home.com>
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com> <20000830220210.C5340@hectic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000830220210.C5340@hectic.net>; from alexsh@hectic.net on Wed, Aug 30, 2000 at 10:02:10PM +0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 30, 2000 at 10:02:10PM +0300, Alex Shnitman wrote:
>
> Hi again,
>
> I'm trying to load a kernel with an initrd image. I have two questions.
>
> First, I'm locating the kernel (via the s-records) at 400000. It then
> relocates to 800000. I'm refering to this output:
>
> DINK32_MAX >>go 400000
> loaded at:     00400000 00414E20
> relocated to:  00800000 00814E20
> zimage at:     0040B000 00489577
> relocated to:  00815000 00893577
> initrd at:     00489577 00533299
> relocated to:  00893577 0093D299
> avail ram:     00400000 00800000
>
> After that it boots fine.
>
> If I try to locate it at 800000 to begin with, it fails like this:
>
> DINK32_MAX >>go 800000
> loaded at:     00800000 00814E20
> zimage at:     0080B000 00889577
> initrd at:     00889577 00933299
> avail ram:     00400000 00800000
>
> Linux/PPC load: root=/dev/ram
> Uncompressing Linux...bad gzipped data
> exit
>
> Does that make sense to anyone? Not that it disturbs me, but I'm just
> curious.

The bootloader relocation algorithm doesn't work when loaded at
0x800000.  Anything else will work.

> Second, I'm trying to load an initrd image. I put the compressed
> filesystem image in arch/ppc/boot/ramdisk.image.gz and then did "make
> zImage.initrd", which created zvmlinux.initrd which I'm loading.
> However during bootup it says this:

No clue here.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
