Date: Sat, 7 Oct 2000 13:50:49 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Samuel Rydh <samuel@ibrium.se>,
        Linux Frame Buffer Device Development <linux-fbdev@vuser.vu.union.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>, olh@suse.de
Subject: Re: Video driver bug
In-Reply-To: <Pine.LNX.4.10.10010071939260.398-100000@cassiopeia.home>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1001007134822.9961B-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 7 Oct 2000, Geert Uytterhoeven wrote:

> > This problem is observable if one starts MOL from the console. MOL
> > changes the video mode on an inactive console in order to extract
> > certain video mode parameters (like rowbytes).

Is there anything wrong with using FB_ACTIVATE_TEST flag for this usage?
With the flag, you get a legal var and active fb is untouched.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
