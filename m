Date: Tue, 26 Sep 2000 17:58:47 +0300 (EEST)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: phandel@cise.ufl.edu
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel panic starting XFree86 4.0.1 / Voodoo3 on 2.4-test9 -
In-Reply-To: <Pine.LNX.4.21.0009251704210.2150-100000@like.mine.nu>
Message-ID: <Pine.LNX.4.21.0009261710470.23380-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 25 Sep 2000 phandel@cise.ufl.edu wrote:

>
> I have been successfully using Ani's penguinppc.org::xfree86-pmac tree
> with my Voodoo3 card with a stable 2.2 series kernel (from
> ppc.samba.org::linux-pmac-stable, with the voodoo3 driver from the 2.3
> series).  Today I tried the 2.4-test9 kernel from
> ppc.samba.org::linux-pmac-devel and got the following panic while trying
> to startx:
...
> >From the System.map:
> c00f9fb4 t atyfb_get_var
> c00fa018 t atyfb_set_disp
> c00fa17c t atyfb_set_var
> c00fa388 t atyfb_pan_display
> c00fa410 t atyfb_get_cmap
> c00fa500 t atyfb_set_cmap
>
>
> When I tell XFree86 to use the ATI card instead (via "Screen 1" instead
> of "Screen 2" at the end), it works fine.
>

  The tdfxfb driver doesn't use resource management yet, as a result both
offb and tdfxfb drive the same card, this might be the cause of your
problems.


 Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
