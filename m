Date: Sat, 9 Sep 2000 12:16:43 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: Michel D?nzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org,
        linux-apus-devel@lists.sourceforge.net
Subject: Re: newer xfree86 4.0.1 patches
In-Reply-To: <00090723415902.31531@enzo.bigblue.local>
Message-ID: <Pine.GSO.4.10.10009091208470.13087-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> > We have a CVS repository at SourceForge. Roman Zippel integrates bitkeeper
> > into it, but unfortunately we don't have anyone for the reverse direction.
> > How could that be done?
>
> Via Linus probably, but in this special case we could arrange something.

Most of the changes are in the ppc subtree, so I would rather like to see
if they would go through one of the ppc trees, so they don't break
anything. On the other hand they also need a small cleanup especially some
mm part, as APUS is the only ppc machine where the memory doesn't start at
zero, but here I'm currently still looking for some strange bug - all
kernel virtual doesn't work (ioremap, vmalloc), but at least vmalloc did
work and I see nothing in the changes, what could have broken it, so I'm
still hunting...

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
