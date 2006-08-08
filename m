Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17624.6035.613234.492868@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 14:48:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [RFC] Debugging with a HW probe.
In-Reply-To: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
References: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jimi Xenidis writes:

> +static noinline void xmon_hw_probe(void)
> +{
> +	if (!xmon_hw_probe_enabled)
> +		return;
> +	ATTN();
> +}

I can't see how we can get to call this routine with
xmon_hw_probe_enabled equal to 0...  What am I missing?

Paul.
