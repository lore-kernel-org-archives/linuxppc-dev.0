Date: Wed, 15 Nov 2000 14:28:53 -0800 (PST)
From: "Keith W. Shaw" <keithws@fork.yi.org>
To: Derrik Pates <dpates@andromeda.dsdk12.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: AWACS sound support with 2.4.0-test10 from linuxcare.com
In-Reply-To: <Pine.LNX.4.30.0011092241110.17067-100000@andromeda.dsdk12.net>
Message-ID: <Pine.LNX.4.21.0011151417510.21455-100000@dizzy.fork.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 9 Nov 2000, Derrik Pates wrote:

> The AWACS support does noto work - if built in, it'll pick up an IRQ, and
> play about a half-second of sound if you try to use mpg123 with it. If I
> try to load it as a module, the init fails, then less thank 30 seconds
> after, it dies to a boot monitor. Is there a fix for this anywhere? I'l
> like to be able to use sound with this machine.

I was able to fix that problem by re-enabling "Support for CUDA
based PowerMacs" in "Macintosh device drivers" which i had zealously
turned off thinking i didn't need it. I had also disabled MacIO support,
but I'm not sure if that was it.  I now just leave all items in that sub
section selected.  Not absolutely sure, but that seemed to work for me.

> (This is on a Blue and white G3/250 tower.)
This was on a PowerBook G3 300Mhz (PDQ).

	keith.

:g/windows/s//linux/g


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
