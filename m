Date: Fri, 11 Feb 2000 12:44:18 +0100 (MET)
From: Tobias Otto-Adamczak <Tobias.Otto-Adamczak@e-technik.tu-chemnitz.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: On-Chip-Debugging for MPC 860 ?
In-Reply-To: <200002092058.VAA24849@denx.local.net>
Message-ID: <Pine.GSO.4.21.0002111115480.20126-100000@samson.hrz.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everyone,
I am new to this whole stuff. I'm a student working on diploma thesis.

My goal is to have linux running on MBX board -WITHOUT- EPPC-Bug, booting
diskless out of the flash-ROM and having a ramdisk and a flash-filesystem.

I use a intel-linux-host and some days before got some LinuxPPC tools from
Wolfgang Denk including working GNU cross-compiler and root filesystem
which seem to be really helpful.

I will need some help in the next months ... My first question is:

How to make use of MPC's BDM (with a linux host), if possible via GDB ?
I know that I need an adapter cable for the parallel port.
Actually I have three of them:

* a so-called "EBDI-Lite" from Motorola
* a "CPU32"-cable which was used for debugging the 68360 with GDB
* a very simple cable according to the suggestions of sergey drashnikov
(found in graham stoneys mailing from Jan 27th, which I found really
helpful. Graham, what is the URL for your HOWTO ?)

I also know that I need some patches for the GDB. I have tested two
variants so far:

* Patches working for 68360 from Greg Ungerer. They look professional but
there is no support for the 860 BDM, maybe I could adopt them.
* Patches from Sergey Drashnikov for 860 who are very "quick and
dirty" and didn't work out of the box (he tested under FreeBSD only).

What would you suggest to do ? Is there any "ready-to-use"-solution ? I
know that there are some commercial tools for Windows (Metrowerks, EST)
but what about linux ?  I thought about adopting the GDB-BDM patches for
360 to 860, but I cannot evaluate how much work it is.

Any suggestions welcome. Thanks.
Tobias


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
