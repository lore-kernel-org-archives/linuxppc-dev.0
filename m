Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17784.52970.343161.782030@cargo.ozlabs.ibm.com>
Date: Fri, 8 Dec 2006 13:33:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Worst case performance of up()
In-Reply-To: <1165356002.5469.16.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
	<1165055754.4380.15.camel@localhost.localdomain>
	<1165058151.22108.31.camel@localhost.localdomain>
	<1165060484.4380.18.camel@localhost.localdomain>
	<1165092773.22108.47.camel@localhost.localdomain>
	<1165239794.17906.14.camel@localhost.localdomain>
	<1165263946.29784.13.camel@localhost.localdomain>
	<1165356002.5469.16.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> Paul, do you reckon the best solution here is to clear ppc_md.power_save
> when detecting an SMP powermac ? (Or the flush-on-lock property)

Yes, that sounds good.  It would let us get rid of the runtime cpu
feature check in idle_6xx.c too.

Paul.
