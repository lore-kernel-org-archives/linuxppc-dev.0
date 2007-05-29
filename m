Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25CCEDE057
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 00:21:19 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4TELG9q005665
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 10:21:16 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4TELFBt228406
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 08:21:15 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4TELEUN012449
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 08:21:15 -0600
Subject: Re: Fix problems with Holly's DT representation of ethernet PHYs
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
References: <20070529060541.GG30266@localhost.localdomain>
	<c7c131c3a7fdf7727d9ea1e40775017a@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 29 May 2007 09:19:06 -0500
Message-Id: <1180448346.3360.49.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Paul Mackerras <paulus@samba.org>, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 08:43 +0200, Segher Boessenkool wrote:
> > +		MDIO: mdio@6000 {
> >  			device_type = "mdio";
> > -			compatible = "tsi-ethernet";
> > +			compatible = "tsi-mdio";
> 
> Hrm, did I miss this before?  A more exact "compatible"
> property would be better ("tsi109-mdio" "tsi108-mdio" or
> something like that).

If we must, then tsi108-mdio is what I would recommend.  They are the
same between 108, 109, and 110 as far as I know, so it's the lowest
common denominator.

josh
