MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Accessing nvram rom the linux users space
Date: Tue, 12 Nov 2002 13:39:59 -0500
Message-ID: <3D296C067098F149B11A8F4FC37C05462F21DD@EXVS1.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: <moleschi@rmsweldingsystems.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does it have to be a disk?  The Walnut has a similar setup to
what you are describing and allows you to define a device,
/dev/nvram, that functions as a disk-like object (you can
open it, seek it, read and write it).

  -- David Wright, InfiniSwitch Corp.


> -----Original Message-----
> From: Mike Moleschi [mailto:moleschi@rmsweldingsystems.com]
> Sent: Tuesday, November 12, 2002 1:29 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: Accessing nvram rom the linux users space
>
>
>
> I am using a PPC board running a version of Hard Hat linux, and
> currently using version of the 2.4.20 kernel.  On the board there
> are several places for storage: 32MB of SRAM, 4MB of flash-EPROM,
> 32kB of NVRAM, and 16k-bit serial EEPROM. The SRAM, flash and NVRAM
> are memory mapped.  The NVRAM is actually battery backed up RAM
> that includes a RTC in the last 8 bytes of addressed memory. Right
> now there is nothing stored in the NVRAM (PPC Boot is stored in
> part of the flash, and the PPC environment variable are in the
> serial EEPROM.)  NVRAM is mapped from 0xF0200000 to 0xF0207FFF.
>
> I would like to be able to uses the NVRAM from the linux users
> space.  Ideally it would just be an extention of my filesystem,
> where I could place one or two small files on it.  This would
> let me store information that needs to be kept through a loss of
> power.
>
> So basically I think what I am trying to figure out, is how do I
> mount the NVRAM as a disk.
>
>
>
>
> --
>
>
> Mike Moleschi
> moleschi@rmsweldingsystems.com
> RMS Welding Systems
> 1409 - 4th Street, Nisku, Alberta CANADA	T9E 7M9
> Tel: (780)955-3907	Fax: (780)955-3996
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
