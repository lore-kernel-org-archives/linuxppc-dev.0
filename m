Message-ID: <20000424161311.23404.qmail@web1705.mail.yahoo.com>
Date: Mon, 24 Apr 2000 09:13:11 -0700 (PDT)
From: Gabriel Ricard <g_ricard@yahoo.com>
Subject: Re: Lombard hard freeze
To: Bernhard Reiter <bernhard@intevation.de>, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've had some similar problems, sometimes it bombs
compiling the kernel, sometimes it locks up for no
apparent reason while it's running the screen saver
and hasn't been in use for a while. I haven't a clue
what is going on...

--- Bernhard Reiter <bernhard@intevation.de> wrote:
> Hello Linuxppc developers,
>
> I encounter hard freezes with my lombard G3/400
> Powerbook.
> Though I cannot completely rule out hardware
> problems, it might
> be the software. The system never stopped running in
> MacOS 8.6
> I tried the TechTool Deluxe tests and the Gauge Pro
> Ram Check
> under MacOS without revealing any problems.
>
> The freezes occurr randomly when heavy compiling is
> done.
> (Like I cannot compile gnomehack 1.0.5 three times,
> it usually
> happens in the second compile attempt.) If you want
> to try
> ftp://intevation.de/users/bernhard has the .src.rpm
> right now.
>
> It does not matter if it is cold or warm, X11
> running or pmud running.
> I tested Kernel versions 2.2.14 2.2.15-pre3
> 2.2.15-pre19
> together with the LinuxPPC 2000 install and the
> upgraded LinuxPPC 1999
> install (on two different partitions).
> I upgraded glibc, binutils and gcc.
>
> This powerbook has a 10 GB harddisc and 192 Mb ram,
> so it does not even
> swap for this compile.
>
> Another little detail hints towards a software
> problem:
> Even if I give the computer breaks after, let's say
> the first
> gnomehack compile, it chances to run through the
> next one is not higher.
> It looks like disorder somewhere in the kernel piles
> up, still it is
> a matter of time to lock up the machine.
>
> I would be glad if someone could help me to track
> the problem
> down further. I was told that this is the right
> place to ask.
>
> Regards,
> 	Bernhard
> ps.: Please carbon copy relevant replies to me.
>
> --
> Professional Service around Free Software
>     (intevation.net)
> The FreeGIS Project				            (freegis.org)
> Association for a Free Informational Infrastructure
>           (ffii.org)
>

> ATTACHMENT part 2 application/pgp-signature


=====
Gabriel Ricard
g_ricard@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
