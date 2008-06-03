Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DAE79DE162
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 06:11:27 +1000 (EST)
Message-ID: <4845A55E.2030503@freescale.com>
Date: Tue, 03 Jun 2008 15:11:10 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kevin Diggs <kevdig@hypersurf.com>
Subject: Re: cntlzw
References: <4845A44D.20404@hypersurf.com>
In-Reply-To: <4845A44D.20404@hypersurf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kevin Diggs wrote:
> Hi,
> 
>     x86 has bsf and bsr. PPC has cntlzw which I think is equivalent to 
> bsr. Anyone know of a sneaky algorithm to do bsf?

wordsize - 1 - cntlzw(x & ~(x - 1));

-Scott
