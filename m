From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Benson <erbenson@alaska.net>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>,
	Brad Boyer <flar@pants.nu>
Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
Date: Fri, 28 Dec 2001 12:22:12 +0100
Message-Id: <20011228112212.8707@mailhost.mipsys.com>
In-Reply-To: <20011127155855.G10071@plato.local.lan>
References: <20011127155855.G10071@plato.local.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>well it also doesn't document things like the permission bits, it just
>says they are unused and reserved, obviously this is not the case
>given OSX, apple just has not updated this document.
>
>that means theres a bit of reverse engineering involved as well since
>apple is using a newwer version of HFS+ which is not entirely
>documented.

Darwin source contains the full implentation of HFS+ used by Apple.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
