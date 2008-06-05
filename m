Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 037D7DE8F6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:40:52 +1000 (EST)
Message-ID: <48481705.9080107@freescale.com>
Date: Thu, 05 Jun 2008 11:40:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	
	<20080604220555.658ab13e@vader.jdub.homelinux.org>	
	<20080604231641.786bb2dd@lappy.seanm.ca>	
	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com>	 <484809D1.2070300@scram.de>
	<48480B3C.9080101@freescale.com>	
	<fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>	
	<484811DE.9@freescale.com> <484812B9.3040300@scram.de>
	<fa686aa40806050930r12827baod5d742959c982d0c@mail.gmail.com>
In-Reply-To: <fa686aa40806050930r12827baod5d742959c982d0c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Scott Wood <scottwood@freescale.com>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> 2) for i2c purposes, explicit enumeration is not needed or desired.
> All the necessary data is already present in the device tree in that
> i2c device nodes are children of i2c bus nodes.  The i2c bus numbers
> should be dynamically assigned.

NACK.  For ASoC driver, they cannot be dynamically assigned.  I2C1 must be
labeled as such.

-- 
Timur Tabi
Linux kernel developer at Freescale
