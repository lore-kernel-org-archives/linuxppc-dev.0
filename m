Date: Mon, 19 Nov 2001 13:00:36 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: xfree86/fbdevhw not sending right mode to radeonfb.c
In-Reply-To: <20011118184235.QSWE9849.tomts10-srv.bellnexxia.net@there>
Message-ID: <Pine.LNX.4.33.0111191248340.10443-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 18 Nov 2001, Kevin B. Hendricks wrote:

> I am willing to dig deeper to track this one down if someone can point me
> to the code that parses the mode info from the XF86Config-4 file and loads
> it into the mode structure.

Hello Kevin,

Take a look at xf86parseModesSection(),xf86parseModeLine() etc
in xc/programs/Xserver/hw/xfree86/parser/Monitor.c
and also at configMonitor()
in xc/programs/Xserver/hw/xfree86/common/xf86Config.c

You might want to take a look at the  *Mode*.c files in ..../common
as well.

Good luck.

Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
