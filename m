Message-Id: <199905101943.VAA00322@piglet.cpu.lu>
Date: Mon, 10 May 1999 21:43:21 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Support for Hydra i2c
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
cc: bh40@calva.net, frodol@dds.nl, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.9905101046110.10789-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  10 May, this message from Geert Uytterhoeven echoed through cyberspace:
[snip]
>> > and maybe some more stuffs.
>> 
>> The only device on this I2C bus in the PCI Macs that I know off is the
>> RADACAL RAMDAC/CLUT (used at least with the control chip), which gets
>> its timebase factors via I2C.
>> 
>> > Unfortunately, I think we only know how to write to the i2c bus.
>> 
>> Yes.

On the other hand, you I2C gurus mihgt know that, but the R/W bit on the
I2C bus is actually the lsb of the address; i.e address a device with
an even address, and it expects to recive some data; address it with an
odd address, and the device will write data to the bus.

>> > More hacking needed before we can implement this one too.
>> 
>> One problem might be that there is as yet no readable device on the bus
>> ;-).
>
> Really? Since i2c devices need to identify on the bus, you must be able to read
> something from them.

I did some experimentation on the cuda I2C bus while searching for the
PlanB I2C device. I scanned a whole range of I2C addresses, both read
and write, but didn't find anything apart from RADACAL.

> Are there OF methods for the i2c bus on those Macs? My CHRP box has them under
> /pci/mac-io@2/misc@0/iic/.

I'll check in OF on the next reboot ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
