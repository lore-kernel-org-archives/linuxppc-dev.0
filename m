Message-ID: <3DD15BF9.6050500@rmsweldingsystems.com>
Date: Tue, 12 Nov 2002 12:52:25 -0700
From: Mike Moleschi <moleschi@rmsweldingsystems.com>
Reply-To: moleschi@rmsweldingsystems.com
MIME-Version: 1.0
To: "Wright, David" <dwright@infiniswitch.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Accessing nvram rom the linux users space
References: <3D296C067098F149B11A8F4FC37C05462F21DD@EXVS1.ops.infiniswitch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I guess it has to be a disk in that I would like to have a file
system on it and move files around on it -- basically I want to
be able to treat it like a disk from a command line perspective.

I can access the nvram through a C program using open() and mmap(),
but I would like to be level higher then that.



Mike



Wright, David wrote:
> Does it have to be a disk?  The Walnut has a similar setup to
> what you are describing and allows you to define a device,
> /dev/nvram, that functions as a disk-like object (you can
> open it, seek it, read and write it).
>
>   -- David Wright, InfiniSwitch Corp.
>
>
>
>>-----Original Message-----
>>From: Mike Moleschi [mailto:moleschi@rmsweldingsystems.com]
>>Sent: Tuesday, November 12, 2002 1:29 PM
>>To: linuxppc-embedded@lists.linuxppc.org
>>Subject: Accessing nvram rom the linux users space
>>
>>
>>
>>I am using a PPC board running a version of Hard Hat linux, and
>>currently using version of the 2.4.20 kernel.  On the board there
>>are several places for storage: 32MB of SRAM, 4MB of flash-EPROM,
>>32kB of NVRAM, and 16k-bit serial EEPROM. The SRAM, flash and NVRAM
>>are memory mapped.  The NVRAM is actually battery backed up RAM
>>that includes a RTC in the last 8 bytes of addressed memory. Right
>>now there is nothing stored in the NVRAM (PPC Boot is stored in
>>part of the flash, and the PPC environment variable are in the
>>serial EEPROM.)  NVRAM is mapped from 0xF0200000 to 0xF0207FFF.
>>
>>I would like to be able to uses the NVRAM from the linux users
>>space.  Ideally it would just be an extention of my filesystem,
>>where I could place one or two small files on it.  This would
>>let me store information that needs to be kept through a loss of
>>power.
>>
>>So basically I think what I am trying to figure out, is how do I
>>mount the NVRAM as a disk.
>>
>>
>>
>>
>>--
>>
>>
>>Mike Moleschi
>>moleschi@rmsweldingsystems.com
>>RMS Welding Systems
>>1409 - 4th Street, Nisku, Alberta CANADA	T9E 7M9
>>Tel: (780)955-3907	Fax: (780)955-3996
>>
>>
>
>
>
>


--


Mike Moleschi
moleschi@rmsweldingsystems.com
RMS Welding Systems
1409 - 4th Street
Nisku, Alberta   CANADA
T9E 7M9
Tel: (780)955-3907
Fax: (780)955-3996


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
