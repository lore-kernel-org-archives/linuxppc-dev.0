From: unit@panix.com
Date: Wed, 26 Apr 2000 00:19:53 -0400 (EDT)
To: Andreas Tobler <toa@pop.agri.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial driver problem (modem Lombard)
In-Reply-To: <39043DF4.92CE26D3@pop.agri.ch>
Message-ID: <Pine.SUN.4.21.0004252354340.1095-100000@panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Apr 2000, Andreas Tobler wrote:

> Which ppp-pkg are you using? I use ppp-2.4.0b2, but ppp-2.3.11 should
> also work fine.

 ppp-2.3.10

> > w/ 2.2.15pre14 i can connect but if i reconnect linux crashes w/ no
> > option other than a force reboot (this has happened on three occasions
> > under the exact same circumstances).

> > i rsynced the pre19 two days back so i'm not sure where i fall into the
> > loop. However it would seem the/my problem is further back
>
> Be sure not having something like ppp_async/ppp_generic in drivers/net/.
> If so you may have the same situation I had.
> rsync -avz linuxcare.com.au:linux-pmac-stable <dest-dir> should help to
> get a clean download.

Andreas .. that was indeed the case .. and i've since re synced from an
older tarball. ppp is now working .. however the hard crashes persist ..
always when i disconnect and reconnect .. once the handshaking is done
the machine locks (no console nothing) and a minute or so later the
machine restarts. I'll try updating ppp but i'm thinking it is maybe a
kernel issue

thanks for your responce

cal-s


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
