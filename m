Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D6F21DDE9E
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 07:06:02 +1100 (EST)
Message-ID: <47828624.6080402@freescale.com>
Date: Mon, 07 Jan 2008 14:05:56 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v5] qe: add ability to upload QE firmware
References: <11970422334145-git-send-email-timur@freescale.com>
	<20071226165004.GA11449@localhost.localdomain>
In-Reply-To: <20071226165004.GA11449@localhost.localdomain>
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

> Please, add compatible "fsl,qe" matching, so this code could
> work with new device trees.

Can you give me an example of this?  I cannot find a single device tree anywhere 
that has this compatible property in it.


-- 
Timur Tabi
Linux kernel developer at Freescale
