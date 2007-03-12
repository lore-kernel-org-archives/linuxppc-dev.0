Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 87B99DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:48:31 +1100 (EST)
Date: Mon, 12 Mar 2007 15:49:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 15/19] bootwrapper: Add dt_ops methods.
Message-ID: <20070312224912.GF31268@mag.az.mvista.com>
References: <20070312204201.GO28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204201.GO28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:42:01PM -0600, Scott Wood wrote:

<snip>

> diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
> index 2b569ad..6b4fd9b 100644
> --- a/arch/powerpc/boot/ops.h
> +++ b/arch/powerpc/boot/ops.h

<snip>

> +static inline int setprop_str(void *devp, const char *name, const char *buf)
> +{
> +	if (dt_ops.setprop)
> +		return dt_ops.setprop(devp, name, buf, strlen(buf));

Shouldn't that be "return dt_ops.setprop(devp, name, buf, strlen(buf) + 1);" ?

Mark
