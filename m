Date: Tue, 24 Jul 2001 17:36:55 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: userspace button controls
In-Reply-To: <20010724015531.516c9985.jpgarcia@execpc.com>
Message-ID: <Pine.LNX.4.33.0107241730190.1912-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Jul 2001, Joseph P. Garcia wrote:

> attached is a tar.gz of a few files I've created as a solution to powerbook buttons.
>
> - buttons.patch: brings all 5 adb-buttons to userspace via NIL's
> events via the keyboard.  New keys added to input.h.  With proper
> support, the user could see these keypresses, and use them.  This also
> does not use the pmac_backlight.c file, in exchange for a new
> framebuffer ioctl, existant in chipsfb, atyfb, and aty128fb.  The only
> interdependancy is between chipsfb/atyfb and via-pmu for backlight
> control for lombard and earlier.  The pmu's backlight ioctl was
> removed.  So sound controls are in the mixer (unchanged), backlight
> controls are in the fb rather than pmu, and the adbbuttons are simple

You're talking about PMU_IOC_SET/GET_BACKLIGHT? Thanks for breaking pmud
:-) Please make that a config option, or get Stephan Leemburg to change
pmud before this leaks into kernels built for the unsuspecting user.

Please don't get me wrong: I'm all for changing this long term, I'd just
rather not see a repeat of the inputdev compatibility fiasco ...

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
