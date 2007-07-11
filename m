Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E40CFDDE2B
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 00:37:33 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6BEbUEZ020918
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 10:37:30 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6BEbUag169346
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 08:37:30 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6BEbU6s027225
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 08:37:30 -0600
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <200707111626.52676.sr@denx.de>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
	<200707111626.52676.sr@denx.de>
Content-Type: text/plain
Date: Wed, 11 Jul 2007 09:37:29 -0500
Message-Id: <1184164649.32199.74.camel@weaponx.rchland.ibm.com>
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

On Wed, 2007-07-11 at 16:26 +0200, Stefan Roese wrote:
> On Wednesday 11 July 2007, Josh Boyer wrote:
> > +		PowerPC,405GP@0 {
> > +			device_type = "cpu";
> > +			reg = <0>;
> > +			clock-frequency = <bebc200>; /* Filled in by zImage */
> > +			timebase-frequency = <0>; /* Filled in by zImage */
> > +			i-cache-line-size = <20>;
> > +			d-cache-line-size = <20>;
> > +			i-cache-size = <8000>;
> > +			d-cache-size = <8000>;
> 
> 405 platforms have 16k cache at most.

Indeed they do.  Copy/paste error.  Will fix before actually submitting
things.  Thanks for the catch!

josh
