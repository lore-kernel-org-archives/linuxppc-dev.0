Subject: Re: ibook G4 Status Report
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cpistagna@vrlteam.org
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040222111847.GX2289@adapter.n0skillz.org>
References: <20040222111847.GX2289@adapter.n0skillz.org>
Content-Type: text/plain
Message-Id: <1077484051.852.77.camel@gaston>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 08:07:31 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> finally, i'm using a 2.6.1-ben1 with no additional patch or workaround.
>
> i've not tried your suggested hack for the turn back to console problem.
> next week i'll find a couple of minutes to patch X and i'll write a
> report onto this list.

The mode used for cloning the display is picked by the X driver
according to strange rules I don't fully get at this point ;)

Regarding the switch to console, commenting out the various call
to vgaHWxxxx in RADEONSave() & RADEONRestore() may help.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
