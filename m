Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0F83DDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Dec 2008 04:25:02 +1100 (EST)
Message-ID: <49511EC6.3040002@freescale.com>
Date: Tue, 23 Dec 2008 11:24:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH RESEND] powerpc: make udbg 16550 boot console configurable
	for	EMBEDDED
References: <1230037894-26837-1-git-send-email-jacmet@sunsite.dk>
In-Reply-To: <1230037894-26837-1-git-send-email-jacmet@sunsite.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
> - It doesn't respect console= and still outputs console messages even
>   if console isn't ttySx (E.G. if CONFIG_SILENT_CONSOLE is enabled in
>   U-Boot which sets 'console='

I believe it uses /chosen/linux,stdout-path; u-boot could clear that if 
silent console is desired.

> As that isn't always desirable, add a PPC_UDBG_16550_CONSOLE kconfig
> symbol to let the user disable it (only visible if CONFIG_EMBEDDED).

There's an existing CONFIG_PPC_EARLY_DEBUG that it could depend on instead.

-Scott
