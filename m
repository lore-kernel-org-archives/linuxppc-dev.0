Message-ID: <20030809111908.47795.qmail@web8005.mail.in.yahoo.com>
Date: Sat, 9 Aug 2003 04:19:08 -0700 (PDT)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Re: kernel boot up without using PPCBOOT from flash 
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030808054849.E1CC3C59E4@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello.

> Just write the Linux kernel image to flash and
> start it from flash using PPCBoot. See also:
> http://www.denx.de/twiki/bin/view/DULG/LinuxInFlash

I wrote the pMulti image into flash 2a00000
ppcboot is at location 2800000
i did the following settings
setenv bootcmd bootm 0x2a00000
and also  did saveenv ...
once i reset the board it just hangs thats it...
even ppcboot promp does not come ..
i have to burn ppcboot again and again in that case ..
i want the kernel to boot up upon power ..
but here even the existing ppcboot doesnt work ..

this is the fliinfo

=>flinfo

Bank # 1: AMD 29F040 or 29LV040 (4 Mbit, uniform
sectors)
  Size: 2 MB in 8 Sectors
  Sector Start Addresses:
    02800000 (RO) 02840000 (RO) 02880000      028C0000
     02900000
    02940000      02980000      029C0000

Bank # 2: AMD 29F040 or 29LV040 (4 Mbit, uniform
sectors)
  Size: 2 MB in 8 Sectors
  Sector Start Addresses:
    02A00000      02A40000      02A80000      02AC0000
     02B00000
    02B40000      02B80000      02BC0000

Bank # 3: AMD 29F040 or 29LV040 (4 Mbit, uniform
sectors)
  Size: 2 MB in 8 Sectors
  Sector Start Addresses:
    02C00000      02C40000      02C80000      02CC0000
     02D00000
    02D40000      02D80000      02DC0000

Bank # 4: AMD 29F040 or 29LV040 (4 Mbit, uniform
sectors)
  Size: 2 MB in 8 Sectors
  Sector Start Addresses:
    02E00000      02E40000      02E80000      02EC0000
     02F00000
    02F40000      02F80000      02FC0000


Bytes transferred = 1685861 (19b965 hex)
=>cp.b 400000 2a00000 19b966
Copy to Flash... done
=>setenv bootcmd bootm 2a00000
=>saveenv
Saving Enviroment to Flash...
Un-Protected 1 sectors
Erasing Flash...
. done
Erased 1 sectors
Writing to Flash... done
Protected 1 sectors
=>Ã  it hangs  at this point.
 how do i go about this problem ?

thanks reagrds

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
