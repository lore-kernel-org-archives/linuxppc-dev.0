Message-ID: <38D33510.7B31C928@iiic.ethz.ch>
Date: Sat, 18 Mar 2000 08:49:36 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: "James B. Parker" <pajama1@mindspring.com>
CC: LinuxPPC Developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Xfree86 4.0 (mach stuff)
References: <B4F7E62C.1C2E%pajama1@mindspring.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"James B. Parker" wrote:
>
> I noticed plenty of people working on getting rage128 hardware working with
> 4.0, so where is the support for earlier hardware (rage pro, rage ++,
> whatever)?

The ati driver is for them (although not very well accelerated yet), but I
doubt it works on PPC yet due to the usual problems (endianness, endianness
and endianness, ... :)

Kostas Gewrgiou, me and maybe others are working on a general solution to make
most drivers work with only minor changes or no changes at all.


> I am sure not everyone running LinuxPPC has a rage 128 setup.
> Or am I just missing something (like the same config file works for both)?

No, the Rage128 uses the r128 driver.


> If I knew what the heck to do with the 4.0 config file to get it working
> with my ATI rage pro chip, I certainly would give it a try.
> Any suggestions?

Look at the XF86Config manpage, the format of the file has changed.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
