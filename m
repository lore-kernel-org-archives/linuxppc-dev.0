Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FD1DDDFAE
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 04:43:28 +1000 (EST)
In-Reply-To: <20090528171726.GE3112@pengutronix.de>
References: <4A124202.4010201@doredevelopment.dk>
	<d2b9ea600905260430i72290901p9266de4cade049c1@mail.gmail.com>
	<20090526213351.GG23114@fluff.org.uk>
	<20090528171726.GE3112@pengutronix.de>
Subject: Re: [PATCH v2] i2c-mpc: generate START condition after STOP caused	by
	read i2c_msg
To: Wolfram Sang <w.sang@pengutronix.de>
Message-ID: <OF7FD989BC.A9165CFB-ONC12575C4.006693BB-C12575C4.0066D974@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 28 May 2009 20:43:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Esben Haabendal <esbenhaabendal@gmail.com>,
	Esben Haabendal <eha@doredevelopment.dk>,
	Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfram Sang <w.sang@pengutronix.de> wrote on 28/05/2009 19:17:26:
>
> > > Any blockers to get this accepted?
> >
> > It would be nice to get an ack from someone who can actually test
> > the driver before getting this merged.
>
> I wanted to test it, but it does not apply due to line breaks (check
> @@-line). Also, I don't really have the time to dig into the topic, so I
> would only test it and give a tested-by-tag if it doesn't break anything
> here. I think Joakim would be a good candidate for an acked-by .

It sure looks OK, even at a closer look :)
Acked-by:  Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
