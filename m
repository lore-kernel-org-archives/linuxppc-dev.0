Message-Id: <200003272102.XAA00353@piglet.grunz.lu>
Date: Mon, 27 Mar 2000 23:02:34 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: pci-resources feedback
To: schmitz@opal.biophys.uni-duesseldorf.de
cc: toa@pop.agri.ch, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.10.10003272157250.2447-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Mar, this message from Michael Schmitz echoed through cyberspace:
>>
>> Here the resource code notices the conflict on the ATI.
>>
>> > PCI: Resource 81803000-81803fff (f=200, d=0, p=0)
>> > PCI: Resource 81802000-81802fff (f=200, d=0, p=0)
>> >   for root[0:ffffffff] min[80000000] size[1000]
>> >   got res[80000000:80000fff] for resource 2
>>
>> This is the message as the conflicting (second) region of the ATI gets
>> remapped. It did work... as can be seen ba the lspci outtput.
>
> And it even used the right function (the one in drivers/pci/ to do it. Now
> what kernel version was that with?

If I am not mistaken, 2.3.99 with the following patch applied:

http://www.cpu.lu/~mlan/linux/dev/2.3.99-pre3-pci.diff

> Seems the wallstreet was another one of the 'broken mapping for atyfb'
> boxes. XFree86 4.0 should work fine now.

;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
