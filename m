Date: Thu, 31 Oct 2002 07:44:15 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Hangs after "Now Booting the kernel "
Message-ID: <20021031074415.A2977@home.com>
References: <000701c28053$dd0f6610$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000701c28053$dd0f6610$370da8c0@aman>; from aman@mistralsoftware.com on Thu, Oct 31, 2002 at 02:05:19AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 31, 2002 at 02:05:19AM +0530, Aman wrote:
>
> Hi All
>
> I have build a image using the command make zImage.initrd. This gives a
> linux image zImage.initrd.ebony[Ramdisk + Kernel Image]. This image run fine
> in the PPC440 evalkit. However the same image if I run in my custom board
> which has a 440GP processor, it hangs after saying "now booting the kernel".
> What might be the problem ?.

You might see linuxppc-commit archives or read changeset descriptions for
440 checkins in your BK repo.  Where the image is relocated and the
minimum memory assumption is extremely critical...if you changed any
of it for your custom port you can shoot yourself in the foot.

> I have one more question , is the TLB setting is reconfigured during linux
> image booting , if so is it possible to get the memory map of that.

Read head_440.S

--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
