From: Benjamin Herrenschmidt <bh40@calva.net>
To: Ethan Benson <erbenson@alaska.net>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MacOS X and yaboot wars.
Date: Fri, 22 Sep 2000 18:04:02 +0200
Message-Id: <19340817093546.32417@mailhost.mipsys.com>
In-Reply-To: <20000921214002.N30638@plato.local.lan>
References: <20000921214002.N30638@plato.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>nah, unless macosx actually flashed a new linux hostile bootrom in
>place just resetting the nvram will certainly blow away whatever they
>did.  (its possible though unlikely that they search for linux
>bootstrap partitions and destroy them, i suppose)
>
>> BTW, MacOS X doesn't have gcc available until November, so it isn't really
>> worth bothering with (unless you like lots of eye candy).
>
>eye candy eye smandy, i really quite like my 1024x768 framebuffer
>console ;-) (even if it is a bit slow)

Their installer does something weird, indeed. It tends to randomly make
another partition of the target disk "vanish". The partition (typically,
the HFS "exchange" partition people keep around) does not appear any more
in the MacOS 9 Finder nor in the file selection dialogs. It still mounts
in Linux and MacOS X.

Apparently, the problem seem to be related to the installer setting the
"invisible" bit of the toplevel (root) directory entry of the HFS volume.
The partition is actually mounted, but invisible. I "fixed" mine using
Norton Disk Editor (Norton Utilities), but there might be other ways.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
