Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFC7@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: uncached user space mapping with mmap() ???
Date: Thu, 4 Mar 2004 15:47:29 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:
>> Please refer to "11.13. Accessing peripherals from user space"
>> in the excellent FAQ from DENX's TWiki at :
>>
>>
http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Accessin
>> gPeripheralsFromUserSpace
>>
>> There's no need to implement kernel side stuff. /dev/mem is enough.
>
>Oh! Nice. Thanks a million! It actually works (on my ARM board!)

Glad to hear it!

>So why will people need their own mmap() driver if this kind of things
>can be done via /dev/mem ???

For fun :)

Or weird(read clever) mappings.

>And: Can I mmap() 32MB of peripheral memory into user space?

I don't see any reason why you would not be able to.
The best answer is try it, and see for yourself.


Regards,

--
Stéphane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
