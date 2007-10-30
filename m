Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 10:08:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/4] PowerPC: 440GRx Rainier DTS.
Message-ID: <20071030230805.GC2784@localhost.localdomain>
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030165650.GA22107@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071030165650.GA22107@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 07:56:50PM +0300, Valentine Barshak wrote:
> PowerPC 440GRx Rainier DTS.
[snip]
> +		SDRAM0: sdram {
> +			device_type = "memory-controller";

How many times do we need to say it...

Don't make up random device_type values.  This does not belong here.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
