Date: Thu, 19 Apr 2001 13:36:32 +0100
Subject: Re: XF4 (mach64) help please
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Ani Joshi <ajoshi@shell.unixbox.com>,
	"Michel Dnzer" <michdaen@iiic.ethz.ch>, k_fukui@highway.ne.jp
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset=""
Message-Id: <20010419123638.58C8ADB9E7@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ani,

excellent...

> The attatched patch fixes the ati driver properly without the use of
> fbdev.  Don't bother to try the option, it is not even implemented in the
> driver.  The patch is against a current cvs tree.  If you try to hand
> patch it against that older version with the fbdev hacks you will run into
> problems as getting rid of the hacks is painful and time consuming.
>
> I'm fairly sure this patch will be fine for all nonGX mach64's, although
> I'm not entirely sure about the Lx/Mobility ones as I don't have one to
> hack with.  Feedback is very welcome.

Yes, it works wonderfully:

built against 4.0.99.3 pulled this morning (05:30 BST)
2.4.4-pre3 (BK yesterday)

----

Please note that "make World" fails for me (with build Servers only as an
option in host.def)  [the mesa stuff, amongst other things falls over]

However, the drivers build and I copied ati_drv.o, ati_misc.o over Kaoru's
4.0.99.2-0b rpms.  (I also copied libfbdevhw.a - but, of course, that no
longer loads).

----

Results:

+ no more flickering lines 2cm from left of screen
+ excellent scroll acceleration.

I'll do X11perf if you're interested - otherwise there's plenty of other
things to do... ;-)

Two points:

1/  the cursor disappears after about 5 seconds __only__ when it's over the
active window (it stays there fine when over an inactive window or the
desktop) -- KDE 2.0beta.

2/  how difficult would it be to plumb the scroll acceleration back into the
console driver?  (would one need access to the NDA stuff?) -- the scrolling
of console is a real problem in blocking sound :-/

thanks for the excellent work,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
