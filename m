Date: Thu, 28 Mar 2002 14:31:17 -0900
From: Ethan Benson <erbenson@alaska.net>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: DST flag in NVRAM revisited (was: Re: NVRAM stuck in DST?)
Message-ID: <20020328143117.X26309@plato.local.lan>
References: <20020328040442.V26309@plato.local.lan> <Pine.GSO.4.21.0203281718540.4979-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.21.0203281718540.4979-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Thu, Mar 28, 2002 at 05:19:56PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 28, 2002 at 05:19:56PM +0100, Geert Uytterhoeven wrote:
>
> Perhaps someone can writes a utility to `patch' MacOS to treat the hardware
> clock being in GMT/UTC/Zulu time? I did a similar thing for AmigaOS many many
> years ago.

or if you want a macos only use OSX, it has no problems with the
hardware clock set to UTC, at least the beta did not.

(i tinkered with the beta, at the time my machine had no trace of
MacOS 8/9 and my nvram contains no macos cruft, that is the timezones
and DST fields are null, OSX showed the proper time, and it never
reset the hardware clock to localtime.)

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
