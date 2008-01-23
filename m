Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED4AADDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 20:03:27 +1100 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Wed, 23 Jan 2008 10:03:14 +0100
References: <20080123002040.5049F24781@gemini.denx.de>
In-Reply-To: <20080123002040.5049F24781@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801231003.15045.jbe@pengutronix.de>
Subject: Re: [MPC5200] problem running FEC and ATA
Cc: "Mehlan, Markus \(Ritter Elektronik\)" <markus.mehlan@ritter-elektronik.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang,

On Wednesday 23 January 2008 01:20, Wolfgang Denk wrote:
> In message <200801211728.22817.jbe@pengutronix.de> you wrote:
> > Is anybody out there with more MPC5200B experience? Can someone tell me
> > why some MPC5200B are need this patch and others not? We have two
> > different systems here (cards from different vendors) with the same
> > processor, one needs this BSDIS-patch and the other not. ???????????????
>
> Is it really exactly the same CPU revision? My guess is that one is
> rev. B and the other one is older...

The one who needs this patch (CPU card vendor 1):

MPC5200CVR400B, M62C REV 1, QCW0723T

The CPUs who do not need this patch (CPU card vendor 2):

SPC5200CBV400B, M62C REV 1, QAG0610C
MPC5200CVR400B, M62C REV 1, QAJ0613F


Best regards
Juergen Beisert

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
