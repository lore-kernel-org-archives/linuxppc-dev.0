Date: Thu, 23 Nov 2000 15:12:58 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Tony Mantler <nicoya@apia.dhs.org>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Avery Pennarun <apenwarr@worldvisions.ca>, daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <v04003a20b642c8d1ea1a@[24.70.162.12]>
Message-ID: <Pine.HPX.4.10.10011231508240.21126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 23 Nov 2000, Tony Mantler wrote:

> >Now /etc/mtab is also somewhat redundant with /proc/mounts. Actually you
> >should be able to link /etc/mtab to /proc/mounts but it raises a lot of
> >problems and does not work satifactorily in my experience.
> [...]
>
> I think technically the /proc filesystem is optional. Requiring /proc for
> mount to function gives you another fun chicken + egg of how the heck do
> you then mount /proc on startup? ;)

Because mount stats /etc/mtab and does not touch it if it finds that it is
a symlink. But this has still problem, I just can't remember which ones. I
know that I thought it would be great and had to go back to the standard
/etc/mtab.

Indeed proc is optional, but in practice it has become a necessary evil.
Most systems won't boot without it, hey most init scripts now have a look
at /proc/cmdline and whatnots. Ugly as hell...

> At the risk of drifting way off topic, it might be worth looking at
> rewriting mount and fellow /etc/mtab users to just never need to use a file
> like /etc/mtab. I can particularily recall a few times where a stale,
> unwritable /etc/mtab made some system reconfiguration and/or system
> recovery about 5 times more annoying than it needed to be.
>
> 30 years of unix tradition be damned, /etc/mtab sucks.

Indeed.

	Cheers,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
