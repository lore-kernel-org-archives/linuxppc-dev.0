Message-ID: <3AA69A1D.F1F85B48@denise.shiny.it>
Date: Wed, 07 Mar 2001 21:29:17 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Timothy A. Seufert" <tas@mindspring.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Console text selection bug
References: <Pine.LNX.4.05.10103060750360.29713-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> It's an endian bug in fbcon when accessing the text/attribute buffer.

> Nevertheless, it's a bug. Can someone please change fbcon_invert_region() to
> use scr_{read,write}w() to access the shadow screen buffer and see whether it
> works? Patches are accepted at linux-fbdev-devel@lists.sourceforge.net :-)

Yes, it's an endianess bug.  scr_{read,write}w() are defined as normal
assignments in vt_buffer.h, so I wonder where is the bug. Is the shadow buffer
supposed to be native endian ?


Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
