Return-Path: <joe@perches.com>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 (using SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6A1732C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 17:14:28 +1000 (EST)
Message-ID: <1369898064.22004.134.camel@joe-AO722>
Subject: Re: [PATCH] powerpc/pseries: use 'true' instead of '1' for
 orderly_poweroff
From: Joe Perches <joe@perches.com>
To: liguang <lig.fnst@cn.fujitsu.com>
Date: Thu, 30 May 2013 00:14:24 -0700
In-Reply-To: <1369897651-23770-1-git-send-email-lig.fnst@cn.fujitsu.com>
References: <1369897651-23770-1-git-send-email-lig.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-30 at 15:07 +0800, liguang wrote:
> orderly_poweroff is expecting a bool parameter, so
> use 'ture' instead '1'
[]
> diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
[]
> @@ -162,7 +162,7 @@ void rtas_parse_epow_errlog(struct rtas_error_log *log)
>  
>  	case EPOW_SYSTEM_HALT:
>  		pr_emerg("Firmware initiated power off");
> -		orderly_poweroff(1);
> +		orderly_poweroff(ture);
>  		break;

Compile your patches _before_ submitting them please.

"true" not "ture" here and in the commit message.
