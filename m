Message-ID: <3BA1149F.65E7B1C1@mvista.com>
Date: Thu, 13 Sep 2001 16:18:39 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Peter Barada <pbarada@mail.wm.sps.mot.com>
Cc: mlocke@mvista.com, cdonovan@lanier.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status on 403 (Oak) support
References: <C97ABDA0DC2DD511BA400002A50974132804F1@jdry.lanier.com> <3BA0FA9E.5010204@mvista.com> <200109131951.f8DJpN228832@hyper.wm.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Peter Barada wrote:

> To figure this out we need to know which instructions the assembler
> was trying to assemble.

To me, it's very clear :-).  It was trying to use SPRG4-7 that
don't exist on the 403.....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
