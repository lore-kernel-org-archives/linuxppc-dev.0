Date: Tue, 27 Nov 2001 15:58:55 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
Message-ID: <20011127155855.G10071@plato.local.lan>
References: <20011126231944.E10071@plato.local.lan> <20011127172847.33B512B54A@marcus.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011127172847.33B512B54A@marcus.pants.nu>; from flar@pants.nu on Tue, Nov 27, 2001 at 09:28:47AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 09:28:47AM -0800, Brad Boyer wrote:
>
> Well, according to Apple's documentation, the only version of HFS+
> is version 4, so I have no idea what's up with that...

well it also doesn't document things like the permission bits, it just
says they are unused and reserved, obviously this is not the case
given OSX, apple just has not updated this document.

that means theres a bit of reverse engineering involved as well since
apple is using a newwer version of HFS+ which is not entirely
documented.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
