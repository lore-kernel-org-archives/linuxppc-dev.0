Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <s063f6d1.092@EMAIL>
Date: Fri, 26 Mar 2004 09:24:16 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MC850 peripheral support in linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi ,

>> 1) Does the I2C bus support in the kernel works for the internal I2C
controller of MC850
>> 2) Does the RTC support in the kernel (char driver) works for the
internal RTC of MC850
>> 3) Does the PCMCIA support in the kernel (IDE drivers)  works for
the internal PCMCIA Socket controller of MC850

> 3 x yes. But I can only speak of the DENX kernel trees.

I plan to use the latest ELDK from DENX
Is there any known problems in ELDK Distro?
I could see that the ELDK distro is well packed with all toolchains,
kernel and applications.
I could no find out the "target filesystem" ?
Should the target filesystem be created manually from the directory
into which I install all the application RPMs.? Is there any script
files already available doing the same.

How is the kernel and rotofs attachment done ?
Do I need o do it with my bootloader passing command line arguments to
the kernel ? (I plan to use u-boot).

> Don't expect too much of performance out of a 850;  the  tiny
caches
> a major pain.

As far as performance is considered, I do not need very high.
Out of curisity, what exactly is the problem ?




Thanks
--
Rupesh S

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
