Date: Sun, 15 Jul 2001 17:04:46 -0400
From: Ethan Blanton <eblanton@cs.ohiou.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Internal airport card not working? (2.4.6-benh)
Message-ID: <20010715170446.A20595@localhost.localdomain>
References: <20010714131255.A13317@localhost.localdomain> <20010715201118.9038@smtp.wanadoo.fr>
Mime-Version: 1.0
In-Reply-To: <20010715201118.9038@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Sun, Jul 15, 2001 at 10:11:18PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt spake unto us the following wisdom:
> >Removing the driver stack (airport, orinoco, hermes) and reinserting
> >the modules fixes the problem for me...  Until I suspend and resume a
> >few times, at which point I'll have to remove/reinsert again.
> >
> >I know that's not a *fix*, but it should get you working again in the
> >meantime.  :-)
> >Ethan
>
> Interesting. Do you see any error message in the dmesh log ?

Not that I see...  I see nothing in my log until the removal and
reinsertion of the drivers, at which point I just see a 'su' and then
the driver banner messages.

Everything *acts* like it's working, it just doesn't.  If that makes
sense.  :-)
Ethan

--
If I've told you once, I've told you once
And once is all that you needed.
		-- The Refreshments, "Carefree"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
