Date: Thu, 7 Sep 2000 14:09:58 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: newer xfree86 4.0.1 patches
Message-ID: <20000907140958.A23956@suse.de>
References: <20000906213248.A3749@suse.de> <Pine.LNX.4.10.10009071151320.461-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009071151320.461-100000@cassiopeia.home>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 07, Geert Uytterhoeven wrote:

>
> On Wed, 6 Sep 2000, Olaf Hering wrote:
> > There is also a keycode file for ps/2 based machines like PReP and CHRP,
> > called "powerpcps2". It is a workaround, the arrow keys and the page
> > up/down block are dead as example. I guess it is a kernel bug.
>
> So prefixed scancodes don't work? Sounds familiar. I guess this has something
> to do with the X server putting the keyboard in RAW mode (send raw scancodes,
> including prefixes) instead of MEDIUMRAW mode (send keycodes, 1 code for each
> key pres/release) or vice versa.

Franz and me tried to find a solution a couple of weeks/months ago. The
codes above 0xe0 and above are not handled properly AFAIK.

Franz, can you remember that?


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
