Date: Tue, 25 May 2004 10:01:33 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.6 on 8xx (was [PATCH] Driver for FECs on motorola DUET (87x/88x))
In-Reply-To: <40B327EF.2090903@intracom.gr>
Message-ID: <Pine.LNX.4.58.0405250954480.28787@localhost.localdomain>
References: <40A38968.6060701@intracom.gr> <40A4C04A.8060508@intracom.gr>
 <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com> <40B1FB42.1040306@intracom.gr>
 <505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com> <40B327EF.2090903@intracom.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 25 May 2004, Pantelis Antoniou wrote:

> Hi there
>
> Success!!!
>
>   netvia-ppc root # uname -a
>   Linux netvia-ppc 2.6.6 #54 Tue May 25 13:53:27 EEST 2004 ppc ppc ppc
> GNU/Linux
>
> Everything works now, the problem was with the uart driver, had a
> problem with
> the interrupts.

i'm definitely interested in what it took for you to get this to work.
currently, i've got a perfectly working system, booting a 2.4-based
kernel, compiled with ELDK 3.0, on a customized 8xx board.  this system
uses the now-deprecated "devfs".

i bk-cloned the linuxppc-2.5 tree, did "make menuconfig" as best i could
(guessing every so often at some of the new features), compiled a new
kernel and, glory be, actually got the new kernel to boot up to the point
of trying to start "init", at which point it hung.

i'm using embedded planet's planet core bootloader and, although i'd love
to make the switch to u-boot, given that planet core seems to be doing the
job at the moment, i think i won't tempt the gods just yet.  that's a
later project.

given that "devfs" is now technically obsolete, i'm wondering what you did
in terms of the kernel configuration, and what you had to do in your root
filesystem to effect the switch over to (i'm assuming) sysfs+udev.

mind sharing your .config file for this?  i'm not interested in getting
every feature of this board to work at the moment -- just getting to the
command line prompt would make me happy.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
