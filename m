Message-Id: <200005241756.TAA00723@piglet.grunz.lu>
Date: Wed, 24 May 2000 19:56:00 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Promise Ultra/66
To: spiette@generation.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000524130410.C1169@xim.bellglobal.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Simon,

On  24 May, this message from Simon Piette echoed through cyberspace:
[about the promise/66 in a Mac]
>> Forget about these old patches. Go to my PCI page:
>>
>> http://www.cpu.lu/~mlan/linux/dev/pci.html
>>
>> and get yourself my latest patches for either 2.2.15 (kernel.org) or
>> 2.3.99-pre7 (linuxcare.au) kernels. For 2.2.15, you need Andre's patches
>> in addition to mine. Apply his IDE patches first.

To all those interested: there are new patches up for 2.2.15; I screwed
up with the older ones. Went back to an old version of my PCI patches.
Damn ;-)

> Great! It's working without a hitch (but with a few kernel args!).

Which ones are those? I need none; I could do with idebus=xx for bus
frequency; but the default is ok...

> I have to say that I can't put my card in slot 3 or 4, but only in 1 or
> 2. Not an issue for me but you may want to know ...

What was your machine again? There might be an issue either with bus
mastering (some brain-dead designs don't allow bus masters in all slots;
the Promise is a bus master) or with multiple PCI buses. In the first
case there's nothing you can do; in the second case I might have screwed
up my patches....

> Also, the Promise Card is the only one IDE controller on my Mac, but it
> gets detected at ide2 and ide3. Not an isssue for me neither :-)

CONFIG_BLK_DEV_OFFBOARD=y in your .config; the option is 'Boot off-board
chipsets first'. I guess reserving two IDE buses that are not actually
probed is braindamaged PC legacy ;-)

Be carefull when actually activating this, as your disks will change
devices, and your /etc/fstab will be out of sync!

> Thanks for your work! I'll post instructions on linuxppc-user ...

You're welcome ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
