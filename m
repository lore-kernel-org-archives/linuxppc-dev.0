Message-Id: <200003211428.OAA19720@hyperion.valhalla.net>
Date: Tue, 21 Mar 2000 14:24:38 +0000
Subject: Re: dmasound split
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: geert@linux-m68k.org
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert,

dmasound split (update).

G3/Minitower (beige, Machine ID 510, F2 rev) OK
G3/Lombard (Machine ID 406) OK

9600/233 (Machine ID 67)  nope... :-(

/dev/sndstat appears ok
but (I *think* after the first time through which might be OK)
 cat somefile.wav >/dev/dsp breaks up to give a distorted (and apparently
buffer-repeating) mess.
<CTL-C> recovers (and no crash) - but it is broken from then on ... but I
can't be more informative as present..

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
