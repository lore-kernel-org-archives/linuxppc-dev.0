Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3DE33302.4070907@tataelxsi.co.in>
Date: Tue, 26 Nov 2002 14:08:26 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppcboot, linux , hang at the last step
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


caixupeng wrote:
 > but, can you tell me the detail?
 >
 > Does it mean  the kernel has build in ramdisk ?
No. The kernel does not have a built in ramdisk. but it uses the ramdisk
image passed for modules and the like. correct me if I am wrong.
 > or you have to give a ramdisk separately to the kernel boot args?
initrd='ramdisk image' is the option I gave.
I am not very much conversant with linux booting procedure, but I
believe that the initrd image takes all the dependent modules and link
them properly when the kernel is booting up. So even if you choose fs
support in modular format, it will be loaded by the initrd image.

 >>when I passed the initrd option into the kernel.
 >
 > the option is " root=/dev/ram ",  right?
Frankly, I am not sure. someone else might be able to help you.

Thanks and regards,
Om.

caixupeng wrote:
 > very very thanks.
 >
 > but, can you tell me the detail?
 >
 > I didn't choose advanced partion features.
 >
 > and I chose ext2 fs support, and initrd support too.
 >
 > there is a size of ramdisk set in linux config,
 >
 > Does it mean  the kernel has build in ramdisk ?
 > or you have to give a ramdisk separately to the kernel boot args?
 >
 >
 >>when I passed the initrd option into the kernel.
 >
 > the option is " root=/dev/ram ",  right?
 >
 > thank you very much!
 >
 >             edmoon
 >
 > ----- Original Message -----
 > From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
 > To: "caixupeng" <edmoon@huawei.com>
 > Sent: Tuesday, November 26, 2002 1:03 PM
 > Subject: Re: ppcboot, linux , hang at the last step
 >
 >
 >
 >>caixupeng wrote:
 >>
 >>>When I boot a linux image use "bootm ffa00000 ffb00000"
 >>>
 >>>VFS: Cannot open root device "" or 16:01
 >>>Please append a correct "root=" boot option
 >>>Kernel panic: VFS: Unable to mount root fs on 16:01
 >>>
 >>>I have set the "bootargs=root=/dev/ram"
 >>
 >>I faced the same problem, not on ebony.
 >>My configuration was wrong.
 >>1. i did not compile in the advanced partition features and consequently
 >>kernel could not recognize my hda.
 >>2. The problem still persisted. I found out the file system support was
 >>absent. I compiled ext2 fs support into the kernel and tried.
 >>3. I had to create an initrd image using mkinitrd, and all worked fine
 >>when I passed the initrd option into the kernel.
 >>
 >>HTH.
 >>Om.
 >>
 >
 >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
