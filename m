Message-ID: <39858A95.3BF7DEE0@pop.agri.ch>
Date: Mon, 31 Jul 2000 16:17:57 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
References: <39821DD7.ED0DA0A2@embeddededge.com>
	 <39821DD7.ED0DA0A2@embeddededge.com>
	 <v04003a00b5a8c0b923e3@[24.66.67.194]>
	 <v04003a01b5a8c8c70822@[24.66.67.194]>
	 <4.3.2.7.2.20000731140051.0351ff00@mail.munich.netsurf.de> <4.3.2.7.2.20000731152113.03e44d60@mail.lauterbach.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Franz Sirl wrote:

> 2.4 users are not innocent :-). As I said, just don't turn on
> CONFIG_ADBMOUSE. I'm doing that right now, cause the kernel uses linux
> keycodes already internally now, and they will show up externally somewhere
> during 2.5, so doing it for 2.4 with backwards compatibility on by default
> is the best thing to do.

Turning CONFIG_ADBMOUSE off results in a nice kernel panic with two additional
keyboards connected to the adb-port of my wallstreet :-) (No additional mouse
connected)

With only the internal kbd it works so far even with the new LAYER maps.

Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
