To: Michel =?iso-8859-1?q?D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Permedia2 fb on PPC
References: <wrpsnaq0xkx.fsf@hina.wild-wind.fr.eu.org>
	<1007572780.21734.65.camel@pismo>
Reply-To: mzyngier@freesurf.fr
From: Marc ZYNGIER <mzyngier@freesurf.fr>
Date: 05 Dec 2001 23:52:29 +0100
Message-ID: <wrpadwxth3m.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <1007572780.21734.65.camel@pismo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Michel" == Michel Dänzer <michdaen@iiic.ethz.ch> writes:

Michel> Why is this needed?

Because it simply crashes the system without it ;-).

This prevent the driver from using a non-existant (at least on the
board I own) big endian aperture for registers.

Michel> And does it work with the XFree86 glint driver with Option
Michel> "UseFBDev"?

Don't know yet. _Now_ that I have a console (thanks to this patch),
I'll have a look at the X11 thingy.

Regards,

        M.
--
Places change, faces change. Life is so very strange.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
