Message-ID: <3761EB33.D629064C@pobox.com>
Date: Fri, 11 Jun 1999 22:08:07 -0700
From: "Conrad M. Hirano" <placebo2@pobox.com>
Reply-To: placebo2@pobox.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PRAM problem with the latest B&W G3s?
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just got my hands on a 450 MHz B&W G3 and have run into problems
trying to install Linux. I'm wondering if Apple made some changes to the
PRAM which cause an incompatibility with Linux or BootX because of the
symptoms I see.

First, I noticed that Techtool no longer reports the date of manufacture
or the number of hours the computer has been in use. It just lists "N/A"
for both. Apparently, Apple has changed the PRAM in some way.

Second, the kernels for both R4, for the B&W G3, and R5, from the
installer, do not successfully let me get to the respective installers.
After the system hangs, it will not successfully boot the Mac OS off the
hard disk or the CD until I reset the PRAM. It begins to load the Mac OS
and the BootX window appears, but after I dismiss the window, it hangs
before the extension icons appear at the bottom of the screen. I've also
tried booting with no extensions, and the system still hangs.

Booting with the R5 kernel only gets as far as the initial display of
addresses. No kernel messages appear. The R4 kernel gets farther, but a
timeout occurs when checking the partitions on hda, causing a kernel
panic.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
