MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14808.60984.51654.764750@esb.bbn.com>
Date: Mon, 2 Oct 2000 16:21:12 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michel Ddnzer <daenzerm@student.ethz.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org, Jon Erick Ween <jween@som.llu.edu>
Subject: Re: Patch: PCI resource fixup for atyfb (was: Re: xf 4.0.1 + ati driver
 with rage II/rage pro)
In-Reply-To: <Pine.LNX.4.10.10010011928450.9543-100000@opal.biophys.uni-duesseldorf.de>
References: <Pine.LNX.4.21.0009301652040.2538-100000@idd-01.imbc.gr>
	<Pine.LNX.4.10.10010011928450.9543-100000@opal.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > While I still think having a userland PCI resource fixup tool would be
 > nice (at least for debugging purpose) I also promised to come up with a
 > sanitized version of the atyfb resource fixup patch. Here it is, please
 > test it (especially Jon, and R. Shapiro) and tell me if it works.


I patched a kernel.org 2.2.17 kernel, it made no difference in the
behavior.  The fbdev driver works ok, the ati driver crashes linux.


--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
