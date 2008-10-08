Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD8FFDDEFE
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 19:45:01 +1100 (EST)
Message-ID: <48ED1B9E.3020907@freescale.com>
Date: Wed, 08 Oct 2008 15:44:14 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
References: <1223495845-14149-1-git-send-email-timur@freescale.com>	
	<1223496186.8157.82.camel@pasglop>	
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop>
In-Reply-To: <1223498380.8157.86.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> I'm happy with -all- platforms for a given CPU type defaulting to y. 

I'm not sure I understand.  The current Kconfigs defaults to Y for CHRP and PMAC
on *all* PowerPC systems, including those that are neither CHRP nor PMAC.  Are
you saying that's a good thing?

-- 
Timur Tabi
Linux kernel developer at Freescale
