Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 056D1DEA1F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 01:30:13 +1000 (EST)
Message-ID: <484803C6.3090505@freescale.com>
Date: Thu, 05 Jun 2008 10:18:30 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
References: <200806041706.21557.sr@denx.de>	<200806050822.00797.sr@denx.de>	<20080605094852.164f0bc7@hyperion.delvare>	<200806051045.42966.sr@denx.de>
	<20080605065225.739ec4a8@zod.rchland.ibm.com>
In-Reply-To: <20080605065225.739ec4a8@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, Scott Wood <scottwood@freescale.com>,
	Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:

> seems to be a more distinct definition of what this is.  But I have no
> idea how well that would go over, and it would probably need to be
> changed in all the fsl boards as well.

Which would end up breaking backwards compatibility with older device trees.
Like I said earlier, I'm in favor of expanding the definition of "cell-index".

-- 
Timur Tabi
Linux kernel developer at Freescale
