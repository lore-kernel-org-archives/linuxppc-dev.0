Subject: Re: Trouble with 2.6.0-test1 on ibook2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Ryan Boder <icanoop@bitwiser.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030718014622.GA5430@bitwiser.org>
References: <20030718014622.GA5430@bitwiser.org>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1058517715.23548.71.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 18 Jul 2003 10:41:55 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-07-18 at 03:46, Ryan Boder wrote:
> I'm trying to boot 2.6.0-test1 on my ibook2. I compiled a kernel and it
> begins to boot but hangs immediately after the line
>
> openpic: exit
>
> is printed. Or at least seems to hang as the screen stops showing anything
> else and just leaves the messages up to that point forever. It also
> corrupted my file system so I'm reinstalling now.
>
> Has anyone been running the devel kernel on an ibook2? Can anyone give me
> pointers on how to debug or work around this problem when I finish
> reinstalling?

What graphics chip does the machine have, and have you built OFfb into
the kernel? For me, radeonfb hasn't been working with recent 2.5
kernels, in fact there's been no trace whatsoever of it in the kernel
output, as if it wasn't there. I wonder if it's related to the PCI code;
with a 2.4 kernel, I get a lot of PCI related output, like

PCI: Probing PCI hardware
Scanning bus 00
Found 00:58 [106b/002d] 000600 00
Found 00:80 [1002/4c66] 000300 00
Fixup res 1 (101) of dev 00:10.0: 400 -> 802400
Fixups for bus 00
Bus scan for 00 returning with max=00
Scanning bus 10

[ more PCI probing stuff ]

PCI:24:0e.0: Resource 0: f5000000-f5000fff (f=200), vd: 11c1, dev: 5811
Linux NET4.0 for Linux 2.4

whereas with a 2.5 kernel just this:

PCI: Probing PCI hardware
Can't get bus-range for /pci@f2000000/cardbus@1a
BIO: pool of 256 setup, 14Kb (56 bytes/bio)

But then maybe the code in question has just been made less verbose?


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
