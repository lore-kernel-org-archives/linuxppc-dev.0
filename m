From: jcarr@mail.linuxppc.org
Date: Thu, 9 Nov 2000 08:57:21 -0600 (CST)
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Example miboot on new world rom problem
In-Reply-To: <19341004061114.22300@192.168.1.2>
Message-ID: <Pine.LNX.4.21.0011090829230.1582-100000@jcarr.linuxppc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >I was working with a guy who was using startup disk on a new portable. It
> >was sending him into into miboot. I don't know how to fix this
> >problem. I think the only real option is to make a new startup disk
> >control panel for the macos.
> >
> >Basically this guy has to go into OF and do:
> >boot hd:9,\\:tbxi
> >
> >To get to yaboot. This problem is going to kick me in the butt. Heck it's
> >going to kick linux on the powerpc in general in the butt.
>
> Well, I have no problem triggering yaboot & the OF script via Startup
> Disk on the Pismo using a fake system folder.
> What is this user's setup exactly ?

Some new ibook I think. I get the same behavior on the iMac DV. Startup
disk doesn't change the boot-device value on there. Instead, it loads the
first TBXI file from the first HFS partition it finds. Then the MacOS ROM
finds out that "LinuxPPC Boot" is the name of the partition to boot and
then continues...

Thus miboot is loaded on a new world rom machine.

This is the reason I think either:

1) yaboot needs the code from pmac_support.c (aka SetPRAMBoot )

2) We'll have to write a new startup disk control panel( like system disk)

Jeff
jcarr@linuxppc.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
