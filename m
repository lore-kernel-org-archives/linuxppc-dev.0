Date: Wed, 28 Nov 2001 22:10:45 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: 'make rpm' Failing due to i386 bug
Message-ID: <20011128221045.J10071@plato.local.lan>
References: <20011127233224.C23109@cardassian.cse.psu.edu> <20011128104926.C28956@cpe-24-221-152-185.az.sprintbbd.net> <20011128160615.I10071@plato.local.lan> <20011128201949.P29541@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011128201949.P29541@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Nov 28, 2001 at 08:19:49PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 08:19:49PM -0700, Tom Rini wrote:
> > no we have a zImage target, not bzImage which is a i386 specific hack
> > to work around that braindamaged architecture.
>
> No, we as of 2.4.10ish have a 'bzImage' target which calls 'zImage'
> since most of the docs are braindead and say "Now type 'bzImage' or
> 'bzdisk'".

hrm, i would have made it echo something like:

	bzImage is a i386 specific hack, it is not supported by any other
	architecure.  Use make zImage instead.

rather then just silently perpetuate further ignorance.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
