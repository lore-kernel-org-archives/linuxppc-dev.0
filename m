From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Help! Getting aty128fb.c to work with newest sawtooth machines
Date: Sat, 11 Mar 2000 09:38:39 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0003060013070.30614-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00031109361000.07471@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

If just received a G4 450 but if I try to use aty128fb.c in any resolution
higher than 1024x768 8bpp it will fail miserably with the screen split into 3
vertical panes.

If I try blindly launching xf 4.0 r128, it inherits the fb mode and I end up
with 3 panes as well.

This is obviously a aty128fb.c problem since it occurs in the console.

I looked at Anthony's code (remember the problem I had earlier when he tried to
read values for the dotclock and xclk out of the of device tree?) and then used
lsprop to print out the graphics card info.

Unfortunately, there were no nice of-tree variables in my G4 tree at all but it
did report my card as a Rage128Pro and not a simple Rage128.

Is a Rage128Pro different from a Rage128 when it comes to setting it up,
register usage, etc or is this simply a problem with the default timings
setting being incorrect for this card?

Interestingly enough, I can boot with aty128fb with 1024x768 and 8bpp and the
console is fine (no 3 panes) and I can then successfully start up XFree4.0 with
r128 acceleration so things do appear to be working under some cases.

Is there any tool (code piece, etc) I can use to probe the timing info as used
under MacOS?

Thanks,

Kevin

 -- Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
