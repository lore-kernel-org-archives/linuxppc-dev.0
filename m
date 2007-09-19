Return-Path: <dgibson@ozlabs.org>
Date: Wed, 19 Sep 2007 11:05:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 2/2] PowerPC: Fix Sequoia MAL0 and EMAC dts entries.
Message-ID: <20070919010526.GA23646@localhost.localdomain>
References: <20070918172510.GA30944@ru.mvista.com>
	<20070918172913.GA31098@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070918172913.GA31098@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 09:29:13PM +0400, Valentine Barshak wrote:
> According to PowerPC 440EPx documentation,
> MAL0 is comprised of four channels (two transmit and two receive).
> Each channel is dedicated to one of two EMAC cores.
> This patch fixes Sequoia DTS MAL0 entry and EMAC entries,
> assigning correct channel numbers to EMACs.

Hrm.. did they change the EMAC in 440EPx to only use one MAL
tx-channel?  All the older ones could use two (for no readily apparent
reason, IMO).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
