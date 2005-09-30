Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3EA0F68387
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Oct 2005 06:28:17 +1000 (EST)
In-Reply-To: <433D9BCE.5000909@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
	<433D9BCE.5000909@iki.fi>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 30 Sep 2005 16:28:20 -0400
To: Kalle Pokki <kalle.pokki@iki.fi>
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


On Sep 30, 2005, at 4:10 PM, Kalle Pokki wrote:

> ..... Still, there must be a correct way of doing this, but I think I 
> have already tried modifying every register that sounds related. The 
> errata doesn't list anything useful.

I just built an 8250. 8260, and 8270 from a very recent 2.6 tree today 
and they
all worked fine.  They all had different serial port configurations 
(SMC1, SCC1
and SCC2).  Two were u-boot and one was a proprietary boot rom.
So, the "problem" seems to be related to something unique with your 
system.

> .... I successfully tried this in another application without Linux.

This is code that has existed for many years in Linux and appears to 
continue
to work fine.  We need to identify what is causing the problem in your
environment, not look for some hack around it.

Thanks.

	-- Dan
