Message-ID: <392185D6.FF1EEA13@visuelle-maschinen.de>
Date: Tue, 16 May 2000 19:31:02 +0200
From: Thomas Hvhenleitner <th@visuelle-maschinen.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [linux-fbdev] ctfb for CT65554/CT69000 version 0.2 availiable
References: <Pine.LNX.4.05.10005161649300.15758-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

>
> Does it also support the CT65550? If yes, perhaps it could be merged with
> chipsfb.c?
>

The CT65550, CT65554, CT65555, CT69000 are very similar chips.
I have only access to CT65554 and CT69000 based hw.

Actually I started with the chipsfb.c but there is nearly all different
now because
I needed to support different video modes and also tv out.

Everybody should feel free to extend and modify the code or use parts of
it in different drivers.

Actually it is a good idea to merge chipsfb and ctfb. If someone could
test on CT65550 or CT65555 based hw I could support testing on CT65554
and CT69000.

Thomas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
