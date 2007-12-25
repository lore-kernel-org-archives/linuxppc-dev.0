Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4CAB3DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 07:44:34 +1100 (EST)
Message-ID: <47716BBE.5090000@freescale.com>
Date: Tue, 25 Dec 2007 14:44:46 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
References: <20071221202309.GA4557@localhost.localdomain>	<476DD544.2050807@freescale.com>
	<20071224121546.GA7903@localhost.localdomain>
In-Reply-To: <20071224121546.GA7903@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> Yup. I've seen it, thanks. I'm going to test it as well. ;-)

If they work for you, please let Kumar know.

> MPC8360E, Rev: 21. Are you aware of any known issues on this chip
> regarding UCC serials?

Yep.  You need a microcode upload.  My patches describe everything.
