Message-ID: <XFMail.001103153639.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19340928070822.11693@192.168.1.2>
Date: Fri, 03 Nov 2000 15:36:39 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Lots of problems
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Hi!
>>This is a list of problems I have with official kernels and my G3 (350, SCSI)
>>and a G4 (400, ide) of a friend:
>
> Well, first, developement on PPC kernels is done on hq.fsmlabs.com
> bitkeeper trees. Linus doesn't always have the latest fixes. We do send
> patches quite regulary, but they are not always merged immediately by Linus.
>
> Look at www.penguinppc.org for more infos about those trees.

Are the trees at rsync://vger.samba.org/vger-2.X up to date ?

> Paul sent Linus a set of patches against test10 final, they have not been
> merged by Linus yet.
>
>>- 2.4.0t7: G3 and G4 OK. Resource collisions errors can be removed hacking
>>pci.c.
>
>>- 2.4.0t9, resource collisions: I can't boot my G3 because it doesn't see my
>>SCSI controller. On the G4 it reports collisions even if there are no PCI
>>cards.
>
> PCI have been long fixed in the bitkeeper tree.

Fine :-)

>>- 2.4.0t9, USB: I tried HID, HIDBP, everything. No way to make USB working
>>on the G4.
>
> Works nicely with HID kbd on the bitkeeper tree.

On my G3 HIDBP works fine too.

>>- 2.2.15p3, linuxppc2000: The G4 doesn't boot, lost interrupts.
>>
>>- 2.2.16+USB: The G4 doesn't boot, lost interrupts.
>>
>>- 2.2.16-something from YDL: G4, Works fine but a lots things are missing, I
>>could not find the sources :(
>>
>>- 2.2.18p19: G3 crashes at boot, probably USB related (usb-HIDBP). G4 and
>>usb-HID not tried yet (I'll do it this night).
>
> For 2.2, I strongly suggest you use either the bitkeeper tree on
> hq.fsmlabs.com, or Paul Mackerras rsync tree. I beleive Paul will send
> updates to Alan soon, we have a huge diff against the official 2.2.x tree
> for now.

I'll try paul trees this night on my G3 and on the G4 within a few days.

>>- all: G4 internal modem doesn't work. Suggestions ? I absolutely need it !!
>
> That's something I've not checked. Paul fixed some internal modem issues
> in macserial.c recently, I beleive those fixes are in the bk and rsync trees.

The stealth port on my G3 works fine. I thought that card is only an interface
and the real serial chip is on the motherboard... G4 is different ?

>>- 2.4.0*: G4 ethernet goes at 100Mbps even if it's connected to a 10Mbps
>>hub. Is
>>there a way to force it to a lower speed ? Can the G3 eth go at 100MBps ?
>
> You need the latest gmac driver which is, again, in the trees mentioned
> above.

Ok.

Another little thing: I just upgraded to MacOS904. Booting with BootX linux
freezes as soon as it accesses the mixer. If I boot without extensions, linux
doens't crash but I have no sound. No problems with yaboot. (known prob., uh?)


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
