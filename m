Date: Fri, 20 Oct 2000 22:39:04 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Michael K. Fleming" <mikef@praxis.etla.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Mac Pismo external display?
In-Reply-To: <Pine.LNX.4.10.10010201140220.10663-100000@praxis.etla.net>
Message-ID: <Pine.LNX.4.10.10010202237001.11309-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Has anyone gotten the external display (VGA--although I'd like to get the
> S-Video working as well) working on a Mac Pismo?
>
> I plugged a monitor in and it didn't "just" work, so I really don't know
> where to go from here.  (I'm running XF401 with the newer R128 drivers).

If it doesn't 'just work' if you plug in the monitor after booting Linux
(using yaboot), you're SOL.

> Under MacOS, the external display appears as a separate head, so I assume
> there must be some way to instruct XF401 to treat the external display
> connector as a separate display device.

Sure, just get the r128 specs from ATI, and hack away.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
