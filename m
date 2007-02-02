Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 80400DDED8
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Feb 2007 09:28:37 +1100 (EST)
Message-ID: <45C3BB0A.1020307@am.sony.com>
Date: Fri, 02 Feb 2007 14:28:26 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [1/9] pasemi: Default root device
References: <20070202045448.145851000@lixom.net>>
	<20070202045507.589087000@lixom.net>>
In-Reply-To: <20070202045507.589087000@lixom.net>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Set up default root device on the pasemi platform.
> +	if (ROOT_DEV == 0) {
> +#ifdef  CONFIG_ROOT_NFS
> +		ROOT_DEV = Root_NFS;
> +#else
> +		ROOT_DEV = Root_SDA1;
> +#endif

Christoph told me these are no longer desired in new
platform code.

-Geoff
