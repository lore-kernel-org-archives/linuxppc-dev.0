Message-Id: <se75cb10.022@mail.frequentis.com>
Date: Mon, 17 Mar 2003 13:17:36 +0100
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-embedded@lists.linuxppc.org>, <gue@rettung.at>
Subject: Re: linux on dsp-board as ELF?
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Günther!

Our Company produce PPC boards since 1996, since 2001 (I think) we have linux on it.
So from history we have also an own bootstrapper, that only wait for data from the serial line and write the data into the RAM, Afterwards the adress where to jump will be transmitted.
Of course it detect also if an application is stored in flash.

So we wrote a small programm which write a RAM region into flash, After this programm we append the linux Image (mbx file). So the whole data will be stored in RAM, and afterwards it will be copy the real linux kernel into flash.
The rest of initializion we do in the boot files of linux (arch/ppc/boot/mbx).

But in the mbx file after the first 64kByte strat the real application (jump in), we cut the first 64kbyte.

Hope this helps a little bit

Have fun

Gerhard

>>> Guenther SOMMER <gue@rettung.at> 03/16/03 12:03am >>>

hmm, i've not a great knowledge with ELF.

my board-firmware has the possibility to download a image to the sdram
as ELF-file... a linux zImage is also a ELF-file... but the kernel will
give the wrong parameters if i will download it, or is there a
workaround possible?

greetings, guenther sommer.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
