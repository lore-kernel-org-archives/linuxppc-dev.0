Message-ID: <3BA83D9D.87F9B1E1@mvista.com>
Date: Wed, 19 Sep 2001 02:39:25 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
References: <20010917152316.O3851@zax> <3BA62583.55E48A97@mvista.com> <20010918102901.A1183@zax> <3BA7980B.EEBF1F5D@mvista.com> <20010919121954.D13693@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> Ah, yes, I discovered ATOMIC_SYNC_FIX after I sent that,....

I thought it was automatically enabled on the 405GP.....I guess not.

> .....  That should certainly fix the atomic ops, however there
> are quite a number of other places where the kernel uses stwcx., which
> ATOMIX_SYNC_FIX doesn't fix

I took a quick look at the original patch and saw that too, I just never
got around to fixing the rest of it.  It solved the problem at the time,
so it didn't seem urgent.  If you would like to finish it up, that would
be great.

Thanks.

	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
