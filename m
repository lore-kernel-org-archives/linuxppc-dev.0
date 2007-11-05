Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B179DDDDD6
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 23:55:57 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] pasemi: Broaden specific references to 1682M
Date: Mon, 5 Nov 2007 13:55:28 +0100
References: <20071105032802.GA16613@lixom.net>
In-Reply-To: <20071105032802.GA16613@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711051355.28877.mb@bu3sch.de>
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 05 November 2007 04:28:02 Olof Johansson wrote:
> [POWERPC] pasemi: Broaden specific references to 1682M
>     
> There will be more product numbers in the future than just PA6T-1682M,
> but they will share much of the features. Remove some of the explicit
> references and compatibility checks with 1682M, and replace most of them
> with the more generic term "PWRficient".
>     
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> ---
> 
> This one touches drivers/char/hw_random and drivers/edac, but I'd prefer
> to just merge it up through the powerpc merge path since the changes
> are trivial.
> 
> (Michael, Doug, if you disagree let me know and I can submit separate
> patches. This is 2.6.25 material anyway).

Acked-by: Michael Buesch <mb@bu3sch.de>


-- 
Greetings Michael.
