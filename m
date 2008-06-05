Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 653B2DE9DE
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:44:17 +1000 (EST)
Message-ID: <484809D1.2070300@scram.de>
Date: Thu, 05 Jun 2008 17:44:17 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	<20080604220555.658ab13e@vader.jdub.homelinux.org>	<20080604231641.786bb2dd@lappy.seanm.ca>	<200806050822.00797.sr@denx.de>
	<4848036D.5060004@freescale.com>
In-Reply-To: <4848036D.5060004@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Timur,

> In situations where it doesn't matter which I2C bus is #1 and which one is #2,
> then I think the code should just initialize idx based on the order the nodes
> are found in the tree.
> 
> In situations where it does matter, then we should use cell-index.

that's what I did in i2c-cpm, as well. However, here I use the property
"linux,i2c-index" instead (see http://patchwork.ozlabs.org/linuxppc/patch?id=18603).

Thanks,
Jochen
