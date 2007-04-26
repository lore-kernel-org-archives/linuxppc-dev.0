Return-Path: <b07421@freescale.com>
Date: Thu, 26 Apr 2007 11:42:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070426164226.GA13018@ld0162-tx32.am.freescale.net>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000151.GM4046@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070426000151.GM4046@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 25, 2007 at 05:01:51PM -0700, Mark A. Greer wrote:
> +	chosen {
> +		linux,platform = <1>;
> +		bootargs = "ip=on console=ttyMM0";
> +		linux,stdout-path = "/mv64x60/mpsc@8000";
> +	};

Isn't linux,platform obsolete?

-Scott
