Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.1.6.2.20030528132553.0128a2f0@corelis.com>
Date: Wed, 28 May 2003 13:53:08 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: "Brian S. Park" <brian@corelis.com>
Subject: Re: getting Linux working on IBM Walnut demo board
In-Reply-To: <3ED517C5.1050102@mrv.com>
References: <5.1.1.6.2.20030528113157.012b1008@corelis.com>
 <5.1.1.6.2.20030527160449.0128b868@corelis.com>
 <Your message of "Tue, 27 May 2003 11:49:51 PDT." <5.1.1.6.2.20030527114004.01282240@corelis.com>
 <5.1.1.6.2.20030527160449.0128b868@corelis.com>
 <5.1.1.6.2.20030528113157.012b1008@corelis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank you all for good suggestions.

It turned out that ELDK default setup does not have any dev files. How do I
create all the dev files I need?

 >[root@karla2 dev]# ls
 >initctl  log  null

Also, I have a general question about Embedded Linux.
What is the reasonable amount of flash to have for a minimally configured
Embedded Linux system?

My target will be running small (<<1MB) program which will take commands
over TCP/IP network.
So, I want to know how much flash memory we should put on our custom target.
We do not need support for PCI/Video/Sound/HD/SCSI/Parallel port/...
All we need from the OS is network support. Probably using Linux is an
overkill but since it's free. :)

Thank you for any input.

Brian


Is this normal? Do I now need to configure the target file system to enable
telnet?
>>Or is there still something wrong with my bootargs?
>
>It's not normal. Perhaps it's a problem with inetd or xinetd
>configuration? is there any more information in the logs or in dmesg
>(well, once you get a working console..)?
>
>>Also, after the kernel comes up, I can no longer type any command through
>>the serial terminal.
>>The following the message at the end of kernel boot. It says it was
>>unable to open the console.
>>
>> >IP-Config: Complete:
>> >      device=eth0, addr=192.168.1.146, mask=255.255.255.0, gw=192.168.1.2,
>> >     host=192.168.1.146, domain=, nis-domain=(none),
>> >     bootserver=192.168.1.78, rootserver=192.168.1.78, rootpath=
>> >NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>> >Looking up port of RPC 100003/2 on 192.168.1.78
>> >Looking up port of RPC 100005/1 on 192.168.1.78
>> >VFS: Mounted root (nfs filesystem).
>> >Freeing unused kernel memory: 76k init
>> >Warning: unable to open an initial console.
>
>Perhaps you dont have a proper /dev/ttyS0 device in the nfsroot?

===============================================================
Brian S. Park  brian@corelis.com  (562) 926-6727 x143
---------------------------------------------------------------
Everything we do helps our customers get to market
FASTER with HIGHER quality and LOWER cost
===============================================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
