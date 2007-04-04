Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 2EC25DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 18:49:53 +1000 (EST)
Date: Wed, 4 Apr 2007 10:49:50 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto read I2C on MPC5200 Lite
Message-ID: <20070404084950.GF18236@moe.telargo.com>
References: <20070307122430.GA73298@server.idefix.lan>
	<4b73d43f0703071317o7ae5e531s5eb4b390d41a1b88@mail.gmail.com>
	<20070309113506.GB6726@server.idefix.lan>
	<4b73d43f0703090911y3c2898cdmfdb84f8c7f5da8f@mail.gmail.com>
	<20070309234251.GA68997@server.idefix.lan>
	<20070311005535.GA39488@server.idefix.lan>
	<20070315095758.GE14658@moe.telargo.com>
	<20070317085749.GA75794@server.idefix.lan>
	<20070321083410.GA67297@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321083410.GA67297@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 21/03/07 09:34 +0100, Matthias Fechner wrote:
> Hi,
> 
> * Matthias Fechner <idefix@fechner.net> [17-03-07 09:57]:
> > ok, I can confirm that this patch fixes the problem for me too.
> > I was now able to read my I2C sensor 97388 successfully and only 2814
> > readfailures happened.
> > That means an errorrate of 2.8% that is ok for me.
> 
> I found now when it happens or better when it not happens.
> 
> I boot my icecube board via NFS. If the board is up and I unplug the
> network I get no read errors.
> If the network is connected (NFS server responding) I got read errors
> on I2C with a rate of approximatly 3-4%.
> Seems to be a problem with the network driver.

I can't reproduce your no-errors behaviour. I tried unplugging network
cable and compiling out the fec driver.


	Domen
