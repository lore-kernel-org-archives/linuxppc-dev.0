Date: Tue, 23 Dec 2003 11:35:55 -0500
From: Martin Hicks <mort@bork.org>
To: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded initrd with static programs
Message-ID: <20031223163555.GE702@localhost>
References: <158EF4B20EA8C84D9DC71A55216D2E1C066C71@csy-exchange1.giat.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <158EF4B20EA8C84D9DC71A55216D2E1C066C71@csy-exchange1.giat.intra>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 23, 2003 at 05:06:55PM +0100, ARIBAUD Albert wrote:
>
> > So basically I need the other two programs also statically
> > compiled, does anyone of any idea on how I would go about
> > this??
>
> Mybe I am missing something, but why not use the dynamically
> linked versions and include the necessary libraries in the
> initial ramdisk?

It really depends on how many apps you're including.  If you only need
one app then copying all of glibc in is a waste.  If you've got a bunch
of apps then it's probably better to copy on the shared libs.

On the other hand, if you can get all your apps to compile against
uClibc (or one of the other small libs replacements) then you'll be much
better off.  glibc is huge.

mh

--
Martin Hicks || mort@bork.org || PGP/GnuPG: 0x4C7F2BEE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
