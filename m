Message-Id: <200010170601.IAA06906@piglet.grunz.lu>
Date: Tue, 17 Oct 2000 08:01:30 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: linux-pmac-stable SMP issues
To: nicoya@apia.dhs.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04003a01b6115952b7fe@[24.70.162.14]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  16 Oct, this message from Tony Mantler echoed through cyberspace:
> The second thing I noticed is that "Processor 1 is stuck.". I seem to
> recall this issue has been brought up once or twice before, but a look
> through the mailing list archives didn't reveal any clues.
>
> I vaguely recall the issue might be related to the booter used, I'm using
> BootX 1.2.2 (from MacOS 9.0.4). Is there a different booter I should be
> using to acheive full SMP functionality - hopefully one that allows easy
> dual-booting?

It might not work as you want for dual booting, but you might want to
try OF booting with quik. It's rather manual, but it may bring up your
second processor...

> Other than that, things work rather well, though 5 MB/s powermac scsi is
> anything but spectacular (10MB/s made lots of stuff segfault) - leaves the
> system feeling a tad sluggish compared to, say, my SGI Indigo2, but I
> suppose that's not really a fair comparison to begin with. :)

PowerMac SCSI has always been on the slow side.... Nevertheless, I have
no problem running my MESH SCSI (7600) at 10MB/s. Strange... Maybe
that's why the default speed is 5 MB/s. Although, since the external
(53Cxx) also runs at 5 MB/s, and the internal SCSI is meant to be
faster, I'd say MacOS runs it at 10MB/s also?

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
