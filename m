Message-ID: <3E982570.6040207@mvista.com>
Date: Sat, 12 Apr 2003 09:40:48 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Anand Franklin J <franklin@innomedia.soft.net>
Cc: Craig Hollabaugh <craig@hollabaugh.com>,
	LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Kernel panic: No init found!!!!
References: <3E96E4B6.582DA2F9@innomedia.soft.net> <1050076574.463.2.camel@gibson> <3E97AA29.E44CBAD8@innomedia.soft.net>
In-Reply-To: <3E97AA29.E44CBAD8@innomedia.soft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You also need to ensure that all libraries required by /sbin/init are also
provided.  Use the "ldd" (or objdump -p /sbin/init | grep NEEDED) to get a list
of all libraries required to be on your ram disk.  (In addition to the libraries
make sure you have ld.so.. that is the dynamic loader.)

--Mark

Anand Franklin J wrote:
> hi Craig
> I do have the /sbin/init file in my harddisk. what i performed is manally i
> partitioned the harddisk into 3 , runned mkfs.ext2 then tune2fs on the
> /dev/hda1 partition. copied all utilties from ppc directory(target) like
> etc,bin,sbin... into /dev/hda1. configured the kernel to mount from harddisk.
> still i don't know what is the problem.
> thanking you.
> franklin.
> Craig Hollabaugh wrote:
>
>
>>On Fri, 2003-04-11 at 09:52, Anand Franklin J wrote:
>>
>>>hello All,
>>>    I as using the Redwood 6 IBM PPC board. The Kernel gives the panic
>>>when it boots (Kernel panic: No init found). can anybody say what is the
>>>way to get rid off it.
>>>thanking you,
>>
>>Do you have a /sbin/init file?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
