Subject: Re: [PATCH] MPC85XX TSEC driver: fix for mdio speed
From: Jon Loeliger <jdl@freescale.com>
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: Andy Fleming <afleming@motorola.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1089788421.5959.15.camel@lucy.pep-kaufbeuren.de>
References: <22C48749-C9D2-11D8-B201-000393DBC2E8@freescale.com>
	 <6429F663-D53A-11D8-8835-000393C30512@freescale.com>
	 <1089788421.5959.15.camel@lucy.pep-kaufbeuren.de>
Content-Type: text/plain
Message-Id: <1089817209.17810.87.camel@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Date: 14 Jul 2004 10:00:09 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-07-14 at 02:00, Stefan Nickl wrote:

> Btw: Can support for the 8541 be expected anytime soon?
>      I added some #defines to my platform code, but I didn't look
>      closely into it's incarnation of the CPM yet.
>
> --
> Stefan Nickl
> Kontron Modular Computers

Just yesterday, I was given The Nod to release the 8555/8541
sources for U-Boot.  Linux likely follows shortly.

jdl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
