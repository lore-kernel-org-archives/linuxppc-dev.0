Date: Wed, 30 Jan 2002 17:39:28 -0700 (MST)
From: daRonin <daronin@digimerc.com>
To: Derrik Pates <dpates@dsdk12.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE:  Radeon DRI support patch
In-Reply-To: <Pine.LNX.4.43.0201241431430.29327-100000@andromeda.dsdk12.net>
Message-ID: <Pine.LNX.4.33.0201301736300.1321-100000@daronin.digimerc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 24 Jan 2002, Derrik Pates wrote:

> On Thu, 24 Jan 2002, daRonin wrote:
>
> > I install benh kernel and applied your patches on my new Powerbook Titanium.
> >
> > Seems to be working, it's nice to get more than 400FPS. Unfortunately it still seems to be a bit flaky.
> >
> > It does freeze the machine randomly when running GLX apps.
>
> That's the ever-lovely UniNorth AGP adding joy to your day. Ben's still
> working on getting the kinks out of supporting it - it's weird.

  Yes, weird would describe it. After running it for a while, even without
it crashing the system, after a while the GLX libs just seem to disappear
from /usr/X11/lib/modules/extensions. No log or console messages, nothing.
Very weird...

daRonin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
