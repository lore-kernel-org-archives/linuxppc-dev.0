Message-ID: <6B546A602AD2D211BFF00008C7A42889041D6BDE@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: "Kernel logical address"  vs "Physical"
Date: Fri, 14 Sep 2001 10:44:36 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a fairly basic question about "Kernel logical address" and "Physical
address".


In the book about Linux Device Drivers (first and second edition) from
Alessandro Rubini I read:

"Logical addresses make up the normal address-space of the kernel. . On most
architectures, logical and their associated physical addresses differ only
by a constant offset." __pa() is used to go from logical address to Physical
address; __va() the other way round.



I have been working on a PPC platform, running Linux 2.2. This platform has
a register where you can enable different options and where you can control
several LED's. The vendor mentions that this register is mapped in memory at
FA400000.

When I write (in a driver)

char *p=0xFA40000;

*p = ..; (I know I should use writeb to be more portable.)

it seems to work; the leds can be manipulated. But as FA400000 is a physical
address, I thought that it had to be *p=__va(0xFA40000);



Who can help me out? Where do I find a nice document about this?



Thanks,

Frederic


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
