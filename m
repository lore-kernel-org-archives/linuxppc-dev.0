Message-Id: <200009280600.IAA00829@piglet.grunz.lu>
Date: Thu, 28 Sep 2000 08:00:40 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI fixups (was: re: xf 4.0.1 with rage II/rage...)
To: bh40@calva.net
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19340822040450.7355@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  27 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
> I'm not very confident on the device tree content on those UniNorth
> machines. I prefer reading the decoded regions from the address select
> register of the bridge itself ;) (There's code in Darwin that shows how
> it works).

I don't mind you doing that ;-) Is there any standard for reading these
things off the bridge?

> Where can I find your patch that does this region hacking ?

http://www.cpu.lu/~mlan/linux/dev/2.4.0-t6-pci.diff

Or, more generally, at:

http://www.cpu.lu/~mlan/linux/dev/pci.html

Have fun!

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
