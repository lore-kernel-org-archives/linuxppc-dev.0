Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/16] Port 44x MMU definitions to ARCH=powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adafy9am14g.fsf@cisco.com>
References: <20070213061024.B4A8CDDD0D@ozlabs.org>
	<1171347875.20192.63.camel@localhost.localdomain>
	<adafy9am14g.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 08:36:58 +1100
Message-Id: <1171402618.20192.100.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 09:13 -0800, Roland Dreier wrote:
>  > > +typedef unsigned long long phys_addr_t;
>  > > +extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
>  > > +#define PHYS_FMT	"%16Lx"
>  > 
>  > Do we still need that fixup code ? Since we now have full 64 bits
>  > capable ioremap, we don't need to play tricks anymore. I'd rather get
>  > rid of them completely.
> 
> Maybe make the fixup code print a warning when it actually changes an
> address below 4G so we can track down all the places relying on this?

Good idea.

Ben.
