Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E32FDDFED
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:11:24 +1000 (EST)
Date: Mon, 15 Oct 2007 12:11:18 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] i2c: Add devtree-aware iic support for PPC4xx
Message-ID: <20071015191118.GA9733@gate.ebshome.net>
References: <200710151529.11485.sr@denx.de>
	<20071015163216.GA8127@gate.ebshome.net>
	<fa686aa40710150957s74693835g257b376adfdb4e90@mail.gmail.com>
	<20071015185340.GB4474@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071015185340.GB4474@loki.buserror.net>
Cc: Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	i2c@lm-sensors.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 01:53:40PM -0500, Scott Wood wrote:
> Though, I don't see what the problem with the original approach is, as long
> as the numbers are chosen in the same way when registering i2c clients based
> on the children of the adapter node.  There's no concept in the hardware
> itself of a bus number.

Huh? As far as I can tell, there is. Also, I want messages from the 
kernel mention something I can map to the real hw, e.g. fixed IIC 
device index, not some random number.

This already works with the current OCP code, so if you want change 
it to a "superior" technology, please, make sure it provides the same 
functionality as trivial OCP one.

I find it rather puzzling that instead people are trying to make 
this a non-issue as soon as it cannot be implemented easily with 
their new and shiny infrastructure.

-- 
Eugene
