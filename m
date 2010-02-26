Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE1F8B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Feb 2010 05:36:21 +1100 (EST)
Date: Fri, 26 Feb 2010 12:35:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: Peter Pan <pppeterpppan@gmail.com>
Subject: Re: Does Linux 2.6.32 support NAND flash connect with MPC8247
	through localbus with GPCM mode?
Message-ID: <20100226183559.GA17941@loki.buserror.net>
References: <48abf2c21002251808v4d40ea42s869b1307dfc3817@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48abf2c21002251808v4d40ea42s869b1307dfc3817@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2010 at 10:08:09AM +0800, Peter Pan wrote:
> I'm recently porting Linux 2.6.32 to our custom board with MPC8247. We have a
> NAND flash connected using GPCM mode of local bus. But after I search
> through the Linux
> source, there is no compatible like "fsl,gpcm-nand". And I can not
> find any driver
> that seems works for our scene.

There isn't one.  I was not under the impression that such a configuration
was even possible (how do you control ALE/CLE, for example?).  There is a
NAND driver that uses UPM, though -- perhaps you could use that?

How specifically is NAND connected to the SoC on your board?  What about it
suggests GPCM?

-Scott
