Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: yellowdog-devel@lists.yellowdoglinux.com
Subject: SMP kernel seems to work fine
Date: Sat, 16 Feb 2002 10:39:38 -0500
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.BSF.4.44.0202131947110.42574-100000@shell.unixbox.com> <20020215110330.PVOP20323.tomts20-srv.bellnexxia.net@there> <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
In-Reply-To: <20020216043145.GJVX19277.tomts22-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20020216154023.FWQU23257.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The SMP kernel I just built seems to work fine (no stress testing has been
done yet but the UP seemed quite stable.).

So the bottom line is with only a few patches to help the kernel recognize
the 7455 processor (which are probably already in Ben's tree already) and
some small changes to the  kernel radeon frame buffer code (to help it
find the OF EDID, determine which ports are being used, stop playing with
the TMDS_transmitter_cntl, etc

We can pretty much almost fully support the new PowerMac G4's Apple just
announced (as long as they opt for the Radeon 7500 card in the BTO).

BTW: the sound volume problem in the kernel can be worked around with
external speakers.

Also, with this combination, XF 4.2.0 seems to work out of the box.

So basically any distribution that wanted could simply provide a new
installer built with one of Ben's latest kernels (with some added radeonfb
patches), a recent kernel, and XF420 and you could easily claim support
for the latest G4 machines.

Hope this helps!

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
