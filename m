Message-ID: <6334-88322@sneakemail.com>
Date: Thu, 15 Apr 2004 13:14:11 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: System ACE MPU interface to CF card
References: <407470ED.3030607@buckeye.ece.drexel.edu> <6058-40021@sneakemail.com> <407ADCFE.8080302@buckeye.ece.drexel.edu> <25757-52278@sneakemail.com> <407EDCF7.2020009@buckeye.ece.drexel.edu>
In-Reply-To: <407EDCF7.2020009@buckeye.ece.drexel.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sharad Gupta sharad-at-buckeye.ece.drexel.edu |PPC Linux Embedded| wrote:

 > Thanks Stephen,
 >
 > Your patch helped me a lot in compiling and configuring my kernel. Just
 > on a side note, have you been able to talk to compact flash (mount fs on
 > it, fsck it ?) through system ace ?
 >
 > My kernel hangs while doing partition check on the drive. All I ever see is
 >
 > Partition check:
 > xsysacea:
 >
 > (then nothing happens)
 >
 > I am using SanDisk's 128MB CF card and system ace is configured in the
 > byte mode. Any pointers as to why it is not going ahead will be highly
 > appreciated.

Works just peachy for me, with 32M and 256M disks installed. I
have most of my embedded system living on the disk (a little
bit of ramdisk for root, and tmpfs for /tmp) with not a spot
of trouble.

I have noticed that if the disk does not have a .ace file on
it, and a Xilinx chip to program, the driver fails to get any
partition info from the disk and it all fails from there. So
I suspect the driver still to some degree relies on the state
of the chip after a successful Xilinx load. If you are trying
to use the chip without an FPGA attached, you may be running
into that.
--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
