Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: do we need -fPIC for X11R6 modules
Date: Mon, 8 Oct 2001 20:54:57 -0400
Cc: <yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
References: <Pine.BSF.4.32.0110061833480.59459-100000@shell.unixbox.com>
In-Reply-To: <Pine.BSF.4.32.0110061833480.59459-100000@shell.unixbox.com>
MIME-Version: 1.0
Message-Id: <20011009005252.QEEA29786.tomts9-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani,

Quick question.  Should we be building X11R6 modules with -fPIC?  When I
try, the resulting modules generate lots of unresolved symbols (like
"fixup", etc).

What exactly are X11R6 modules?  Are they shared libraries?  If so, they
should be built using -fPIC?  If they are not shared libraries, how are
they "loaded" and "linked" in?

If they are "loaded and linked" into a normal shared library, then -fPIC
should be used anyway.

I guess I don't understand how a load-on-demand module can be created
without -fPIC.

Any guidance you (or anyone else :-) might provide would be greatly
appreciated.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
