Date: Fri, 29 Sep 2000 21:33:35 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Michel Dänzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <14804.46688.113509.984458@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009292131510.7428-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Michael Schmitz writes:
>  > That's not fixable at the X level (well, technically it is but I can't
>  > figure out how and the X people refuse to consider that method). You will
>  > need to boot via OF and yaboot (or equivalent oldworld) directly
>
> I tried miBoot.  Is that equivalent from the X perspective?  I can't

Show me your lspci -vv log :-)

Re: OF device tree, there's a tool named lsprop you need to run on
/proc/device_tree (see Paul's or BenH's pages for the source or ask me
for a copy).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
