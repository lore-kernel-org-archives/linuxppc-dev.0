Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F833DDF50
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 08:31:58 +1000 (EST)
Message-ID: <470D52D3.30104@freescale.com>
Date: Wed, 10 Oct 2007 17:31:47 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 0/2] QE clock source improvements
References: <1192054708946-git-send-email-timur@freescale.com>
In-Reply-To: <1192054708946-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry, please ignore this set.  Something got screwed up with the patches. 
I'm going to resend.

Timur Tabi wrote:
> This patch set adds a new property to make specifying QE clock sources
> easier, adds a function to help parse the property, updates some other
> functions to use an enum instead of an integer, and updates the ucc_geth
> driver to take advantage of all this.
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
