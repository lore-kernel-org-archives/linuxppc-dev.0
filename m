Date: Wed, 27 Sep 2000 21:21:44 +0200 (CEST)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Jon Erick Ween <jween@som.llu.edu>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Olaf Hering <olh@suse.de>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
In-Reply-To: <B5F794D8.631%jween@som.llu.edu>
Message-ID: <Pine.LNX.4.10.10009272119250.10201-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Here's a copy of my XF86Config file.

Only differences I can see:

I don't use HwCursor, and I use ShadowFB off in the device section.

I use mode lines as returned by fbset -x in the monitor section.

Plus I don't use the empty Files section (fontpath there at least).

Order shouldn't matter I hope, otherwise try the layout at the end.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
