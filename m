Date: Tue, 25 May 2004 11:06:32 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.6 on 8xx (was [PATCH] Driver for FECs on motorola DUET (87x/88x))
In-Reply-To: <40B35372.9080201@intracom.gr>
Message-ID: <Pine.LNX.4.58.0405251104470.7779@localhost.localdomain>
References: <40A38968.6060701@intracom.gr> <40A4C04A.8060508@intracom.gr>
 <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com> <40B1FB42.1040306@intracom.gr>
 <505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com> <40B327EF.2090903@intracom.gr>
 <Pine.LNX.4.58.0405250954480.28787@localhost.localdomain> <40B35372.9080201@intracom.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 25 May 2004, Pantelis Antoniou wrote:

>
> Robert P. J. Day wrote:

> >i'm definitely interested in what it took for you to get this to work.
> >currently, i've got a perfectly working system, booting a 2.4-based
> >kernel, compiled with ELDK 3.0, on a customized 8xx board.  this system
> >uses the now-deprecated "devfs".
> >
> I used an NFS mounted root ELDK 3.0 filesystem. By mistake I booted with
> devfs and everything worked except the telnet networked logins.
> Did not have time to check why though.

oh, so devfs, although deprecated, will still work?  that's good to know,
one less thing i need to fight with.

> >i bk-cloned the linuxppc-2.5 tree, did "make menuconfig" as best i could
> >(guessing every so often at some of the new features), compiled a new
> >kernel and, glory be, actually got the new kernel to boot up to the point
> >of trying to start "init", at which point it hung.
> >
> Well you wont get any further than this using the stock kernel.
>
> I had to use my own ethernet and a ported over serial uart driver for CPM2
> boards.
>
> Also some tweaking is needed to the irq dispatch and defining out
> some mmu staff which do not apply for 8xx.

ok, i'll just hang out and wait for changes to eventually appear.  no
big rush on my part.  thanks.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
