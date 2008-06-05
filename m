Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5A53FDF025
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:22:18 +1000 (EST)
Message-ID: <484812B9.3040300@scram.de>
Date: Thu, 05 Jun 2008 18:22:17 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	
	<20080604220555.658ab13e@vader.jdub.homelinux.org>	
	<20080604231641.786bb2dd@lappy.seanm.ca>	
	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com>	 <484809D1.2070300@scram.de>
	<48480B3C.9080101@freescale.com>
	<fa686aa40806050910m2057966csc33b2a671c6265af@mail.gmail.com>
	<484811DE.9@freescale.com>
In-Reply-To: <484811DE.9@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>,
	Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Timur,

> It's a little late for that.  I'm okay with coming up with a new property to
> provide system-level indexing, but it needs to be the same property name for
> each type of device.  I don't want linux,i2c-index and linux,dma-index and
> linux,ssi-index, etc.  I also don't understand why we need the linux, prefix,
> since device enumeration is not specific to Linux.

Full ACK here.

Thanks,
Jochen
