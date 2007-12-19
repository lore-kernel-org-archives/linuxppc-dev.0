Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D3F85DDFA2
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 08:07:54 +1100 (EST)
Message-ID: <47698826.4040209@freescale.com>
Date: Wed, 19 Dec 2007 15:07:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/4] device_type/compatible cleanups
References: <20071219203447.GA18285@localhost.localdomain>
	<47698054.1060909@freescale.com>
	<20071219204853.GA20972@localhost.localdomain>
In-Reply-To: <20071219204853.GA20972@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
> On Wed, Dec 19, 2007 at 02:34:28PM -0600, Scott Wood wrote:
>> Anton Vorontsov wrote:
>>> Scott, I didn't add "fsl,cpm-muram" stuff, it just doesn't make
>>> sense now: qe and cpm anyway using different code base.
>> That should change.
> 
> Sure. When that will change, then it will be sane to change the users,
> I think. ;-) Not the vice versa.

The device tree should describe the hardware, not the degree of 
unnecessary code forking/duplication currently present in Linux.

-Scott
