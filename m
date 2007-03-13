Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id B25A2DDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:21:50 +1100 (EST)
Date: Tue, 13 Mar 2007 14:10:02 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [dtc] Add support for flat device tree format version 17
Message-ID: <20070313211002.GA6985@mag.az.mvista.com>
References: <20070313062240.GA22737@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070313062240.GA22737@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 05:22:40PM +1100, David Gibson wrote:
> Index: dtc/dtc.c
> ===================================================================
> --- dtc.orig/dtc.c	2007-03-13 16:37:01.000000000 +1100
> +++ dtc/dtc.c	2007-03-13 16:37:17.000000000 +1100
> @@ -113,7 +113,7 @@ int main(int argc, char *argv[])
>  	int opt;
>  	FILE *inf = NULL;
>  	FILE *outf = NULL;
> -	int outversion = 0x10;
> +	int outversion = 0x11;

Super-minor nit but since you seem to refer to the version as decimal
'17' everywhere else, why don't you just put '17' here?

Mark
