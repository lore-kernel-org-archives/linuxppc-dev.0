Date: Mon, 31 Jul 2000 18:28:08 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Josh Huber <huber@mclx.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
In-Reply-To: <20000731085355.B617@mclx.com>
Message-ID: <Pine.LNX.4.10.10007311824560.20511-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > However, 300M G3, UW SCSI + 256 Mb RAM ==> 6.5-ish Hours (*all* day was only
> > a slight exaggeration :-).
> >
> > (OK, so I did a kernel build as well [30 mins] and had a screen saver
> > running - but... )
>
> I'm guessing that your screen saver might have been using a bit much
> CPU.  I built XF4 on my powerbook wallstreet 233 in a little under 2
> hours, with no configuration file changes. (except for ProjectRoot).

Similar here on a Lombard 400 MHz - 1.5 hours, with ProjectRoot on a NFS
mount. Only 64 MB RAM, only config file change was not to build fonts.

The screen saver must have been running at over 60% CPU :-)

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
