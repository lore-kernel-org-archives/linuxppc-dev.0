Date: Mon, 3 Dec 2001 03:10:27 -0500 (EST)
From: Bill Fink <billfink@mindspring.com>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: [PATCH] Minor changes to control/imstt/platinum/valkyrie/atyfb
Message-ID: <Pine.LNX.4.33.0112030257230.5627-100000@gwiz.nasa.atd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2 Dec 2001, Tom Rini wrote:

> Wasn't there a tool to fiddle and store the vmode/cmode stuff into NVRAM
> tho which would probably work with all of the other cards?

nvvideo, which could set either a video-mode or a color-mode, but I
don't think the color-mode was the same thing as the cmode.  I had to
use a color-mode of 3 IIRC (with a video-mode of 18) to get a decent
display on a 7200 at work (which had a platinum FB IIRC).

						-Bill


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
