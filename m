MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14804.46688.113509.984458@esb.bbn.com>
Date: Fri, 29 Sep 2000 11:33:52 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Michel Ddnzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009291631490.15714-100000@zirkon.biophys.uni-duesseldorf.de>
References: <14804.42077.837821.274373@esb.bbn.com>
	<Pine.LNX.4.10.10009291631490.15714-100000@zirkon.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > That's not fixable at the X level (well, technically it is but I can't
 > figure out how and the X people refuse to consider that method). You will
 > need to boot via OF and yaboot (or equivalent oldworld) directly

I tried miBoot.  Is that equivalent from the X perspective?  I can't
get X to run with any driver at all, old or new, when the machine is
booted with miBoot.

I haven't yet found a way to quik-boot this ide-only beige g3.  I've
been given some suggestions of things to try, but they guy who
actually owns this machine needs to do real work on it today.  I don't
know when I'll get to play with OF/quik booting.


--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
