Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 30B2CDDED4
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 13:23:14 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l453NCKU012949
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 23:23:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l453NBFa174036
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 21:23:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l453NB1o022393
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 21:23:11 -0600
Subject: Re: [PATCH 3/4] Holly DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070504235111.GA19615@localhost.localdomain>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302560.3026.210.camel@zod.rchland.ibm.com>
	<20070504235111.GA19615@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 04 May 2007 22:18:10 -0500
Message-Id: <1178335090.3393.2.camel@zod.rchland.ibm.com>
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

On Sat, 2007-05-05 at 09:51 +1000, David Gibson wrote:
> On Fri, May 04, 2007 at 01:16:00PM -0500, Josh Boyer wrote:
> > Add Holly/Hickory DTS file
> 
> [...]
> > +		mdio@6000 {
> > +			name = "mdio";
> > +			device_type = "mdio";
> > +			compatible = "tsi-ethernet";
> > +			ethernet-phy@6000 {
> > +				name = "ethernet-phy";
> > +				device_type = "ethernet-phy";
> > +				reg = <6000 50>;
> > +				phy-id = <1>;
> > +				linux,phandle = <421>;
> 
> Kill the explicit phandles, please.

Will do.  Forgot there were still there actually.

josh
