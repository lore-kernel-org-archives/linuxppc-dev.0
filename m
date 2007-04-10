Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD872DDE23
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 04:46:12 +1000 (EST)
Message-ID: <461BDB69.4050405@freescale.com>
Date: Tue, 10 Apr 2007 13:46:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
References: <11757244213581-git-send-email-timur@freescale.com>	<461AAF2F.2020608@freescale.com>
	<DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
In-Reply-To: <DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> If we are "cleaning up" rheap I would suggest we think about moving  
> it to the generic lib directory and have it available for wider use  
> beyond powerpc.

I'm not saying that's a bad idea, but that really is outside the scope of my intentions. 
I'm not really cleaning up rheap as I am fixing one specific problem.

I don't think there's any disagreement here that an integer type (in this case, unsigned 
long) is better than a void * for storing a generic value.  I was really hoping I could 
get a consensus on whether or not *this* patch is good for *our* rheap implementation.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
