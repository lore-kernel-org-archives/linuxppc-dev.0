Date: Mon, 2 Oct 2000 22:27:48 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org, Jon Erick Ween <jween@som.llu.edu>
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati
 driver with rage II/rage pro)
In-Reply-To: <14808.60984.51654.764750@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10010022226060.20845-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > While I still think having a userland PCI resource fixup tool would be
>  > nice (at least for debugging purpose) I also promised to come up with a
>  > sanitized version of the atyfb resource fixup patch. Here it is, please
>  > test it (especially Jon, and R. Shapiro) and tell me if it works.
>
>
> I patched a kernel.org 2.2.17 kernel, it made no difference in the
> behavior.  The fbdev driver works ok, the ati driver crashes linux.

I'm not amused (though not exactly surprised: I said the PCI config looked
sane already on your box).

Just for the record: did you ever try the 2.2.17 source from BenH?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
