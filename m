Message-Id: <199903030711.IAA28369@piglet.cpu.lu>
Date: Wed, 3 Mar 1999 08:11:35 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.2.x kernels and u grading software to minimum req.
To: barretp@mcmail.cis.mcmaster.ca
cc: linuxppc-user-digest@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04003a00b302028aecdb@[10.0.0.2]>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   2 Mar, this message from Paul Barrette echoed through cyberspace:
> I have 2.2.2 running on R4.  I read the
> /usr/src/linux/Documentation/Changes file and noticed that there are a
> number of updates needed (see below).
[snip]
> I also noticed that the following pkgs need to be updated from the standard
> R4 dist:
> insmod (I compiled 2.1.121 a while ago), egcs-2.90.25 980302, ld,
> libc-1.99.so, procps 1.2.7, pstree 16, net-tools1.432, NFS 2.2beta29,
> util-linux 2.6

.... which brings up a big question: Shouldn't there be upgrade areas
for LinuxPPC's releases, like there are for normal RedHat releases? It
seems to me that R4 still contains all the way old ackages, and that
the only updates available are from september last year or so...

Then, this sparks a second question: how about actuallay changing the
packages list in the distribution, so that if I net-install LinuxPPC, I
will always have the latest&greatest, but also bug- and
security-problem-free instal _without_ doing manual upgrades later on?

> Now the $10 question, are there rpms around?  I had a look at
> ftp.linuxppc.org, no luck except for egcs and libc (which I will download
> and re try compilation.)

I had no problem upgrading most (and all the critical ones) from the
mentioned packages, though by getting the maintainer's official and
latest release (not .src.rpm's).

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
