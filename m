Date: Thu, 17 Aug 2000 11:51:43 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Thorsten Sprenger <root@informatik.tu-muenchen.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf4 and lombard
In-Reply-To: <Pine.LNX.4.21.0008161915300.78-200000@anubis.local>
Message-ID: <Pine.LNX.4.10.10008171149260.8338-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> i have compiled xfree 4.0.1 with the latest xfree86-pmac tree from
> linuxppc.org. as kernel i use the latest pmac-stable and pmac-devel from
> linuxcare. when starting the x-server i get a dark screen, final beep and
> - after 180 seconds - the system reboots (kernel panic?).

Boot Linux using yaboot and you should be fine.

> the ati driver doesn't recognize the real amount of videoram, even if i
> use the 'VideoRam'-option. i have attached the some parts of my
> XF86Config.0.log file (the system i use at the moment is really bad - no
> cut'n paste).

See atimach64ppc.c and remove the gratituous videoram=2048 assignment
right after the videoram was set from the fb_fix data. In case it's still
in there, I've not rsynced in a while but forgot to tell Ani about that
one.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
