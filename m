From: unit@panix.com
Date: Sun, 14 May 2000 02:42:15 -0400 (EDT)
To: Bernhard Reiter <bernhard@intevation.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
In-Reply-To: <20000511150009.D8481@cheops.usf.Uni-Osnabrueck.DE>
Message-ID: <Pine.SUN.4.21.0005140159110.4879-100000@panix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi ..

it should also be noted that the wallstreet is suffering hard crashes
also (at least i am) .. just to complicate the issue.

My particular problem (which i had posted to the group a few weeks
back) relates to ppp (though what exactly locks up the machine i have
no idea).

What happens is this:

I am connected via ppp, my connection drops (which it is know to do
reasonably regularly). I restart the connection (/sbin/ifup ppp0), if i
tail -f */messages it goes through the whole connection procedure and
then once the handshaking has taken place, everything locks.
I've attempted to run pppd via console which works,
but the moment i switch console, again everything locks w/ no possiblity
of switching console. I've had this happen under these exact circumstances
on 20+ occasions, so, at least in my case it is reproducable. This only
happens after a modem hang-up, and i have yet to have one instance of
restarting ppp without this happening.

As far as compiling i have had no problems (mozilla being a recent 'large'
compile that wen't w/out incident.

I'm wondering if prehaps X isn't to blame ..

cal-s

machine info:

Powerbook Wallstreet 233mhz
192mbs RAM
pretty much vanilla lppc 2k install
2.2.15pre19 rsynced from linuxcare (pre9 and above  also effected)
XFree86-3.3.6-8a (using FBDev)
ppp-2.4.0b2-1 (though 2.3 was in use prior w/ the same results as above)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
