Date: Mon, 6 Sep 1999 17:12:22 +1000
Message-Id: <199909060712.RAA00937@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: otto@cable.a2000.nl
CC: linuxppc-dev@lists.linuxppc.org, linux-pmac@samba.anu.edu.au
In-reply-to: <37D36242.9A70B7F2@cable.a2000.nl> (message from Otto Moerbeek on
	Mon, 06 Sep 1999 08:42:10 +0200)
Subject: Re: 2.2.12 and USB on a B&W G3
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <37D36242.9A70B7F2@cable.a2000.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Otto Moerbeek <otto@cable.a2000.nl> wrote:

> It looks like some USB work that Paul Mackerras did is not included in
> the 2.2.12 tree. Is someone (Paul?) working on merging these patches
> into 2.2.12?

I sent Alan a patch to update the USB support in 2.2.11 (for inclusion
in 2.2.12).  Apparently Linus gave it the thumbs down because the USB
stuff is still under very active development and he (Linus) didn't
want to be receiving patches against two different source bases, or
something like that.  Oh well. :-(

> Is there an "offfical" opinion if vanilla 2.2.12 should work on B&W
> G3's? Where should I be looking to find this info?

The USB stuff in vanilla 2.2.12 is so old that I would be *extremely*
surprised if it worked.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
