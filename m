Date: Tue, 22 Jun 1999 11:23:19 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: satadru pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
Subject: Re: R5 X setup on B/W G3; OF Setup; USB mouse support
In-Reply-To: <Pine.LNX.4.10.9906220308450.17871-100000@beer.pub.umich.edu>
Message-ID: <Pine.LNX.4.05.9906221120520.15504-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 22 Jun 1999, satadru pramanik wrote:

> After extensively browsing the list archives, and various man pages, i
> have been unable to come to an understanding as to how I should change the
> resolution in X unless I reboot into MacOS, change resolutions, and reboot
> back into Linux.   Is this true?   fbset refuses to change resolutions
> at the console.   

For the Blue&White this is true right now.

> Secondly, I'm using the 2.2.10 kernel sources posted earlier with the USB
> support, and they work fantastically, letting me use the USB keyboard on
> the B/W G3, but the mouse refuses to work inside X...   How do I configure
> X to use the USB mouse, instead of having to hook up a ADB mouse?

It was in the bottom of the mail Paul M sent out..

> Finally, I have been using OF to boot a 7600/132 successfully all the way
> through to 2.2.7.   I'm hearing that the MacOS boot mechanism through
> BootX may cause certain problems, such as the total lack of sound I have
> right now.  I understand that certain coff headers aren't being
> generated correctly for the OF 3.0+ revisions, is this an issue if I have
> already installed Linux on the internal IDE hard disk?   I have messed
> around in OF on the B/W G3 just like I did on the 7600, and as far as I
> can tell, a boot-device setting for the 6th partition on the internal IDE
> disk should be this (looking at the system-disk control panel output):
> /pci@80000000/pci-bridge@d/pci-ata@1/ata-4@0/@0:4

Basically OF on the new machines (imac, Blue&White, Lombard) is very
different from what we had working before.  You're currently stuck with
BootX.  But, if you use the boot extention to start up Linux, you can have
sound again.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
