Date: Thu, 12 Sep 2002 15:08:55 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RamDisk
Message-ID: <20020912150855.A8861@home.com>
References: <001801c25a8e$89884420$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001801c25a8e$89884420$370da8c0@aman>; from aman@mistralsoftware.com on Fri, Sep 13, 2002 at 12:29:35AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 13, 2002 at 12:29:35AM +0530, Aman wrote:
>
> Hi All
>
> I am using a PPC 440 evaluation Kit with openbios as the monitor code. I
> have successfully download kernel image using the NFS. Now I want to create
> a RAMDISK for the PPC 440. After which I want to download the RAMDISK and
> the kernel image to the RAM. My question is, using the monitor
> code(OpenBios), is it possible to download both the image ie RAMDISK and
> Kernel image to the RAM.

Put your compressed ramdisk image in arch/ppc/boot/images/ramdisk.image.gz
and make the zImage.initrd target.  The resulting zImage.initrd.ebony
has the compressed ramdisk image linked in.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
