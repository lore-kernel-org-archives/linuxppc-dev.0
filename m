Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 332C3DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Sep 2007 00:25:51 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8FEPmJl013162
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 10:25:48 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8FEPmhj409568
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:25:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8FEPljZ025175
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 08:25:48 -0600
Subject: Re: [patch 3/4] 4xx: Convert Walnut flash mappings to new binding
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20070915022228.GF25414@localhost.localdomain>
References: <20070914185410.387074000@linux.vnet.ibm.com> >
	<20070914185649.272138000@linux.vnet.ibm.com>
	<20070915022228.GF25414@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 15 Sep 2007 09:25:31 -0500
Message-Id: <1189866331.17593.0.camel@localhost.localdomain>
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

On Sat, 2007-09-15 at 12:22 +1000, David Gibson wrote:
> On Fri, Sep 14, 2007 at 01:54:13PM -0500, Josh Boyer wrote:
> > A new binding for flash devices was recently introduced.  This updates the
> > Walnut DTS to use the new binding.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> We should both really figure out the vendor/device ids of the JEDEC
> flash chips in use here and on Ebony, and add the appropriate
> properties as per the binding.

Yeah, I'll do that soon.

josh
