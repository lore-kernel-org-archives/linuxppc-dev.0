Message-Id: <200404230140.UAA14599@lists.linuxppc.org>
Date: Fri, 23 Apr 2004 09:42:00 +0800
From: "=?utf-8?B?amVmZnk=?=" <leo_guo@jisung.cn>
To: "=?utf-8?B?V29sZmdhbmcgRGVuaw==?=" <wd@denx.de>
Cc: "=?utf-8?B?bGludXhwcGMtZW1iZWRkZWRAbGlzdHMubGludXhwcGM=?=" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: which is the best root File system in embed linux system?
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>In message <20040422154403.6452042E2F@denx.de> you wrote:
>>
>> I have not measure the speed of accessing files, so have not the
>> exact concept:)
>
>Then go back one step: before using any software, start by writing down
>the requirements and specifications.
>
>> Now the EXT2 FS is about 13MB(whithout any applications), maybe it is
>> too biger?
>
>No, this is not the problem.
>
>> Oh, I am sorry that not write the detail! Now we have two kind of
>> 8XX boards, one is MPC855T board, and for low cost, we developed
>> MPC852T, one use 32M DOC, another use 8MB+512KB flash. I have success
>> building a EXT2 FS on DOC, and a JFFS2 FS on flash, but they all
>> seems unstable when turn off/on power frequently, so I am worry now,
>> and I want to know what bring on these unstable problems, our design
>> problems or DOC/FS inherent bugs?
>
>Assuming you use recent MTD and JFFS2 code, then JFFS2 should be
>absolutely stable on the 8MB flash system.
>
>As for ext2 on DOC: this is bounmd to fail, as ext2 was not designed
>to be used in a mode where sudden power-of without previous umount can
>occur.
>
>> Oh..., because turn off the power through hardware power switch, so
>> don't remount the file system!
>
>This is your problem. You cannot use ext2 for such a system, then.

Thanks a lot:)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
