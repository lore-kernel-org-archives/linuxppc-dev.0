Message-ID: <3F5747CC.5060107@einfochips.com>
Date: Thu, 04 Sep 2003 19:40:20 +0530
From: bhavin <bhavinp@einfochips.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with PM826 card
References: <20030904124011.4A3ADC59E4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

   Thanks a bunch for your guidance. It helped a lot. I was able to
download my Linux image to memory and in flash memory after through cp.
But in both the cases when I tried to boot my linux,  the setup got
restarted after giving the message
 > bootm 100000
## Booting image at 00100000 ...
   Image Name:   2.4.5-pre1 initrd for
PM826
   Created:      2003-09-04  13:43:13
UTC
   Image Type:   PowerPC Linux Kernel Image
(gz
   Data Size:    516901 Bytes = 504 kB = 0
MB
   Load Address: 00000000
   Entry Point:  0000000c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ...

Could any one please help me what could be the possible problem as I am
totally new to this area. Or If I can get some pointer on where to look
for this trouble It would be a great help.

Thanks & Regards,
Bhavin Shah
Embedded Engineer
eInfochips Ltd.,
bhavinp@einfochips.com

Wolfgang Denk wrote:

>Dear Bhavin,
>
>in message <3F56C5D3.9080202@einfochips.com> you wrote:
>
>
>>    I am using a PM826 card with our own developed carrier extension
>>board. I have build the ppcboot image. I am booting the image from flash
>>
>>
>
>Please upgrade. PPCBoot is pretty old, and  a  lot  of  modifications
>have been added lately. Please use a recent version of U-Boot instead
>(0.4.7).
>
>
>
>>and through serial communication SCC and I have configured the correct
>>serial channel number from our card's schematics. Now, the ppcboot works
>>but, when I try to write something in flash through ppcboot (either
>>'loadb' command or 'nm' command) the flash contents are not getting
>>
>>
>
>Neither the "loadb" nor "nm" commands can operate directly  on  flash
>memory.  please  download to RAM (or modify the RAM contents) and use
>the "cp" command to write to flash.
>
>
>
>>changed. All other functionality of ppcboot works like erase, read, etc.
>>but all the functionality related to 'write to flash' is not working.
>>
>>
>
>I think all these things are working fine, you are  just  using  them
>wrong.
>
>
>
>>Can any one please suggest me what could be the possible reason??
>>
>>
>
>Read the documentation; see
>http://www.denx.de/twiki/bin/view/DULG/Manual
>
>
>
>>Also, I have one separate program which, I downloaded from somewhere
>>which does some read/write operation to the PM826 card's flash. Through
>>that program the writing is working perfect.
>>
>>
>
>It's working perfectly in PPCBoot and U-Boot, too. Just remember that
>the  command  to  write  to  flash  is  "cp"   (and   it's   variants
>"cp.{l|w|b}").
>
>
>
>>Has it something to do with ppcboot configuration or the addressing mode?
>>
>>
>
>No, it is a user error.
>
>Best regards,
>
>Wolfgang Denk
>
>--
>Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
>Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
>Software suppliers are trying to make their  software  packages  more
>``user-friendly''.  .  .  .  Their best approach, so far, has been to
>take all the old brochures, and stamp the words, ``user-friendly'' on
>the cover.                                               - Bill Gates
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
