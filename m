Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EC0968375
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Oct 2005 19:59:33 +1000 (EST)
Date: Tue, 4 Oct 2005 10:59:17 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Kalle Pokki <kalle.pokki@iki.fi>
Message-Id: <20051004105917.27d93a91.ajz@cambridgebroadband.com>
In-Reply-To: <43423996.7090403@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
	<433D9BCE.5000909@iki.fi>
	<6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
	<433E2530.7090503@iki.fi>
	<26a6f673ac9438729eccfe0c376c6b3d@embeddedalley.com>
	<4340D7EF.2040709@iki.fi> <43423996.7090403@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dan@embeddedalley.com, linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 04 Oct 2005 10:13:10 +0200
Kalle Pokki <kalle.pokki@iki.fi> wrote:

> I found it. It's in the MPC8272 family errata. When setting pipeline
> depth to one everything works. Can you Alex confirm this works also
> for you? 

Hi Kalle,  I've just checked and it makes no difference to the ATM
driver.  In fact, on my platform (PM828+u-boot-1.1.3) the pipeline
depth was already set to 1.

You are probably right that the pipeline depth was the cause of your
problem- but my problem is something else.  I think that Freescale
simply overlooked the ATM external connection table case when
designing the cache coherency protocol - because they offered no way
to assert GBL when external connection tables are accessed.

Alex
