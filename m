Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AA8F68432
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Oct 2005 15:57:10 +1000 (EST)
Message-ID: <433E2530.7090503@iki.fi>
Date: Sat, 01 Oct 2005 07:57:04 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
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
In-Reply-To: <6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
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

Dan Malek wrote:

> I just built an 8250. 8260, and 8270 from a very recent 2.6 tree today 
> and they
> all worked fine.  They all had different serial port configurations 
> (SMC1, SCC1
> and SCC2).  Two were u-boot and one was a proprietary boot rom.
> So, the "problem" seems to be related to something unique with your 
> system.

Yes I'm sure the code in Linux is right. It may be missing some 
initialisation it depends on, but anyway.

My board is an Embedded Planet EP8248 that came with a pre-installed 
version of Linux 2.4. That version works ok, though I don't know what 
modifications were made to the kernel. The source wasn't included...

Currently I boot with PlanetCore, load my own boot loader (I'm going to 
use it exclusively when my own custom board based on 8247 comes out) via 
tftp, and start the most recent kernel.org kenel from it.
