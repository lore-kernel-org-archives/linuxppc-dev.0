Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/16] Port 44x MMU definitions to ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213061024.B4A8CDDD0D@ozlabs.org>
References: <20070213061024.B4A8CDDD0D@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 17:24:34 +1100
Message-Id: <1171347875.20192.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +typedef unsigned long long phys_addr_t;
> +extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
> +#define PHYS_FMT	"%16Lx"

Do we still need that fixup code ? Since we now have full 64 bits
capable ioremap, we don't need to play tricks anymore. I'd rather get
rid of them completely.

Ben.
