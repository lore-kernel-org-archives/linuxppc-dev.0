Message-ID: <37156C34.C1DEE82F@dgs.monash.edu.au>
Date: Thu, 15 Apr 1999 04:33:57 +0000
From: Brendan Simon <brendan@dgs.monash.edu.au>
Reply-To: brendan@dgs.monash.edu.au
MIME-Version: 1.0
To: "john.vanloon@oregonchain.com" <john.vanloon@oregonchain.com>
CC: "linux-embedded-digest@waste.org" <linux-embedded-digest@waste.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>
Subject: Re: Booting Linux from Flash
References: <01BE8665.A0E7B070.john.vanloon@oregonchain.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I would certainly like to get a flash filesystem driver.  I'm not sure if it
is the same thing you are talking about.

I want to boot linux on an powerpc embedded system which has no hard disk.  I
do not want to use lilo.  I imagine that I would have write a simple
bootloader to get the kernel booting.  I want to store the kernel at a known
location in Flash and store a boot image at a known location in Flash.  I then
want to execute the kernel somehow (jump to appropriate address) and pass to
it any parameters required to let it place the boot image in a ram disk.  I
think the kernel lives in the file system so it's a bit of a chicken and egg
problem as far as I can see.  Is the kernel that is booting stored in the boot
image.  If so I guess the boot image has to be uncompressed.  The root
filesystem can be a compressed image though.

Anyone know where I should start with regards to bootloaders or how to get the
kernel booting if I have the kernel and bootimage in Flash somewhere.  Note
the Flash is just memory mapped on a SIMM.  There is no IDE driver or
filesystem on it.  Do I need a Flash device driver ??

Thanks,
Brendan Simon.


John VanLoon wrote:

> I have a driver for a card from advantech. I do not believe that much would
> have to be done to have it usable on a FLASH BOOT BLOCK device. You would
> just need to fill in the details and perhaps add support for multiple
> partitions if you need it (an offset to the beginning is already supported
> allowing booting from compressed image ...) and modify lilo. Let me know if
> you would like such a thing.
> John van Loon
> john.vanloon@oregonchain.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
