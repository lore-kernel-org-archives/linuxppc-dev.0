Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 8F81B68956
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 02:05:57 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 28 Dec 2005 16:05:48 +0100
References: <200512281000.12073.david.jander@protonic.nl>
	<20051227214949.GA8236@mail.gnudd.com>
	<20051228131939.GA17170@mail.gnudd.com>
In-Reply-To: <20051228131939.GA17170@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512281605.49296.david.jander@protonic.nl>
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi again,

On Wednesday 28 December 2005 14:19, Alessandro Rubini wrote:
> > The problem I see with Ocan is that it has a very different API than all
> > the others.
>
> I know. When I started the project there only was one driver, and
> it was already very complex. But it lacked the select method(now
> poll), and had other serious design problems. So I started mine,
> without advertising it.

Most of the time, that is the reason. There is something, but it's broken, and 
to fix it is much more work that re-doing it. Problem is: some people are 
already using it, and code is beeing grown on top of it. It seems a standard 
open-source dilemma.

> Now I have a few happy users, and they want to keep my API in their
> applications, so I'm stuck with it.

Tough indeed. But according to Newton's laws, if we apply some force to it, 
pointing in the right direction, eventually it'll move there, no matter how 
big the object is. Let's try and find out where that direction is ;-)

> Yes, that is how things should be, in an ideal world.

Sorry for trying to be a bit of an idealist ;-)

> It would. Anyone willing to lead this effort? [no offence or humor
> intended, I am interested in following it, but can't lead it myself]

I have too little time and too little experience to do such a thing, but I'd 
happily contribute and follow.

Regards,

-- 
David Jander
Protonic Holland.
