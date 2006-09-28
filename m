Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6CA5467A3A
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 23:38:07 +1000 (EST)
Date: Thu, 28 Sep 2006 17:38:16 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 11/12] Add MPC8360EMDS default dts file
Message-ID: <20060928173816.168d4cc2@vitb.ru.mvista.com>
In-Reply-To: <451B8592.7040609@freescale.com>
References: <451B8592.7040609@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2006 16:19:30 +0800
Li Yang <leoli@freescale.com> wrote:

> +		muram@10000 {
> +			device_type = "muram";
> +			ranges = <0 00010000 0000c000>;
> +	
> +			data-only@0{
> +				reg = <0 c000>;
> +			};
> +		};
> +

Why not to have reg property, showing the allocation ranges? data-only seems redundant as a node... 

> +
> +		brg@640 {
> +			device_type = "brg";
> +			reg = <668 4>; 
> +		};
> +

I am recalling brg's removed from the dts before, since spec is silent guess we do not need it for now.

-- 
Sincerely, 
Vitaly
