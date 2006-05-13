Return-Path: <hangtoo@163.com>
Received: from m5-86.163.com (m5-86.163.com [202.108.5.86])
	by ozlabs.org (Postfix) with SMTP id 2D380679EF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 May 2006 16:23:35 +1000 (EST)
Date: Sat, 13 May 2006 14:21:56 +0800
From: "tony" <hangtoo@163.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: Re:Re: how to mount /dev/ram0 to /
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <44657B5A.00FD1A.21222>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


linuxppc-embedded
>> 
>> after boot up,excute df to see the mount point:
>> ~ # df
>> Filesystem           1k-blocks      Used Available Use% Mounted on
>> ~ # 
>> nothing was mounted.

>Your rc scripts probably did not care to update /etc/mtag as needed.

>Check what "cat /proc/mounts" gives.
____________________________>>>>
	cat /proc/mounts, it gives:
	# cat /proc/mounts
	rootfs / rootfs rw 0 0        
	/dev/root / ext2 rw,nogrpid 0 0
	/proc /proc proc rw,nodiratime 0 0
	#
    by seeing this,so I make a root in /dev dir, it links to /dev/ram0,but still doean't work.
>> the fatab in /etc is like this:
>> /dev/ram0               /               ext2    defaults        1 1
>> none                    /proc           proc    defaults        0 0
>> 
>> anything wrong?

>Probably no part of your rc scripts did anything with the information
>in /etc/fstab ...
------------------------>> 
	but,isn't it auto excuted? 

thanks and regards,

tony
