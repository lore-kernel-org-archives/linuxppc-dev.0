From: jcarr@mail.linuxppc.org
Date: Thu, 9 Nov 2000 17:05:28 -0600 (CST)
To: Ethan Benson <erbenson@alaska.net>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
In-Reply-To: <20001109073814.A4577@plato.local.lan>
Message-ID: <Pine.LNX.4.21.0011091652330.727-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Nov 2000, Ethan Benson wrote:

> On Thu, Nov 09, 2000 at 08:57:21AM -0600, jcarr@mail.linuxppc.org wrote:
> >
> > Some new ibook I think. I get the same behavior on the iMac DV. Startup
> > disk doesn't change the boot-device value on there. Instead, it loads the
>
> thats insane, probably a bug in apple's startup disk control panel...

Tell me about it. :)

> > first TBXI file from the first HFS partition it finds. Then the MacOS ROM
> > finds out that "LinuxPPC Boot" is the name of the partition to boot and
> > then continues...
> >
> > Thus miboot is loaded on a new world rom machine.
> >
> > This is the reason I think either:
> >
> > 1) yaboot needs the code from pmac_support.c (aka SetPRAMBoot )
> >
> > 2) We'll have to write a new startup disk control panel( like system disk)
>
> or 3)  setup the correct type of bootstrap for the current type of
> machine.  then you don't have any of this nonsense.

OK - I'll take a look at the current incarnation
Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
