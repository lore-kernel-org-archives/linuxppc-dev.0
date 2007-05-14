Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C8AA2DDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 04:44:44 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4EIje9r002904
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:45:40 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4EIifXR522280
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:44:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4EIieRd023194
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:44:40 -0400
Subject: Re: [PATCH 1/3] Bamboo DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <92b3319be989145b0191cf9693ddd90c@kernel.crashing.org>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154675.3420.22.camel@zod.rchland.ibm.com>
	<92b3319be989145b0191cf9693ddd90c@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 14 May 2007 13:44:35 -0500
Message-Id: <1179168275.3420.51.camel@zod.rchland.ibm.com>
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

On Mon, 2007-05-14 at 17:21 +0200, Segher Boessenkool wrote:
> > +			i-cache-size = <2000000>;
> > +			d-cache-size = <2000000>;
> 
> 32MB yeah right :-)

Yeah, that's what I get for copying from David ;).

> 
> > +		MAL0: mcmal {
> 
> > +			#address-cells = <0>;
> > +			#size-cells = <0>;
> > +			interrupt-map-mask = <ffffffff>;
> 
> These three properties aren't needed (map-mask defaults
> to all bits, #size is never used, #address defaults to 0
> for interrupt mapping and isn't used in any other context).

Ok.

josh
