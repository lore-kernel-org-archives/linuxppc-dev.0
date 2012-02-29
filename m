Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D855C1007D1
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Feb 2012 12:08:44 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 29 Feb 2012 06:38:41 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1T18dKZ2678938
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Feb 2012 06:38:39 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1T18c8b016445
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Feb 2012 12:08:39 +1100
Date: Wed, 29 Feb 2012 09:08:37 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH
Message-ID: <20120229010837.GA3146@shangw>
References: <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6E82@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6E82@saturn3.aculab.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>  
> > +struct eeh_stats {
> > +	unsigned int no_device;		/* PCI device not found */
> ...
> > +				"no device           =%d\n"
> ...
> 
> Use %u (for all the stats), you really don't want negative
> values printed.

Yes. 

> I've NFI how long wrapping these counters might take!
> If it is feasable (maybe much above 100Hz) then you
> need 64bit counters.
> 

I think it's better to use "u64" here ;-)

> 	David
> 

Thanks,
Gavin
 
