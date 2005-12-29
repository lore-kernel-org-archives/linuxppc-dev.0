Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 270FB68968
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 03:28:21 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 29 Dec 2005 17:28:11 +0100
References: <43B2A902.3090008@varma-el.com>
	<20051228150742.GA18401@mail.gnudd.com>
	<43B3D3F2.6060708@grandegger.com>
In-Reply-To: <43B3D3F2.6060708@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512291728.12181.david.jander@protonic.nl>
Cc: Jan Kiszka <jan.kiszka@web.de>, r.schwebel@pengutronix.de,
	socket-can@pengutronix.de
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

On Thursday 29 December 2005 13:17, Wolfgang Grandegger wrote:
> > That's great. I've always been convinced it is the right way to go.
> > I remember I've said so to a friend in March 2002.  Unfortunately,
> > I had no time to do it the right way, due to short deadlines and
> > tight budget.  I'm happy Robert did it.
>
> FYI, there is also a RTDM/Xenomai based version of the SJA1000
> socket-based CAN driver at
> http://www.rts.uni-hannover.de/mitarbeiter/kiszka/rtaddon/
> As RTDM/Xenomai is avaiable for PowerPC as well, it might be an option.

This is great!
I have been trying out xenomai with 2.6.14 on our MPC8xx hardware, and it 
looks impressive. Still wonder why xenomai hasn't gotten the publicity it 
deserves.
Somehow I had overlooked the example RTDM CAN driver, though.

I also see Robert Schwebel as a member of OSADL, so I am eagerly waiting for a 
news-update on that site also (www.osadl.org).

This could indeed get very interesting, I can't wait to see how Roberts 
implementation looks like.

Thanks to all for the discussion and work on this matter,

-- 
David Jander
Protonic Holland.
