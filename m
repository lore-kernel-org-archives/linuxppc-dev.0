Date: Thu, 29 Jun 2000 03:56:09 -0400 (EDT)
From: Jamie Guinan <guinan@bluebutton.com>
Reply-To: guinan@bluebutton.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX IDE
In-Reply-To: <Pine.LNX.4.21.0006280808460.16924-100000@gemini.home.net>
Message-ID: <Pine.LNX.4.21.0006290329430.23317-100000@gemini.home.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 28 Jun 2000, Jamie Guinan wrote:
>
> There was a thread back in November about getting IDE going on
> an MBX,
>
> http://lists.linuxppc.org/listarcs/linuxppc-embedded/199911/msg00054.html
>
> Did anyone make any progress on this? ...
<snip>

Well, many hours and printk's later,

  hda: 251350AT Maxtor 2.5" Disk Drive (C) 199, 1287MB w/58kB Cache,
  CHS=2616/16/63

I haven't tried formatting it yet, but I managed to write some
raw data on /dev/hda from a Linux program, then read it back in
EPPCBug.  Looks funny, every other 2bytes are 00's, but perhaps
that's expected for doing a blind write() on /dev/hda.

m8xx_setup.c doesn't seem to want both IDE and PCMCIA ATA devices
to exist at the same time, though.  Not sure what to do about that,
but first I have to study interrupts and PCI/ISA busses some
more (I'm a bit rusty on that subject matter).  If I can hack
them to both work at the same time for my own purposes, I'll
be happy.

-Jamie


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
