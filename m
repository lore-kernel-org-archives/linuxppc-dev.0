Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Which XFree86 version has Flat Panel support in Radeon?
Date: Fri, 19 Oct 2001 21:00:20 -0400
References: <Pine.BSF.4.32.0110102251240.17602-300000@shell.unixbox.com>
In-Reply-To: <Pine.BSF.4.32.0110102251240.17602-300000@shell.unixbox.com>
MIME-Version: 1.0
Message-Id: <20011020005756.EKCA12483.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just tried to use my Radeon with the FlatPanel with XFree86 4.1.0 but I
could not get it to work.  I looked in
xc/programs/Xserver/hw/xfree86/drivers/ati at radeon_driver.c and noticed
lots of comments saying Flat Panel support was disabled.

I did see ifdef ENABLE_FLAT_PANEL in places but it was clear that support
was not included completely yet.

I would very much like to use my flat panel display.  Can anyone tell me
which Branch of the XFree86 tree I should go looking for Radeon Flat Panel
support or who (which developer) at Xfree86 I should be e-mailing to get
the bleeding edge so that I can start to work on this.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
